//
//  SwimPlatypus.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 23/04/23.
//

import SwiftUI

import SwiftUI
import SpriteKit

class SwimPlatypusScene: SKScene, SKPhysicsContactDelegate{
    let verticalPipeGap = 250.0
    var platyAlive = true
    var platy2Alive = true
    
    var platy:SKSpriteNode!
    var platy2:SKSpriteNode!
    var platyScore:SKSpriteNode!
    var platy2Score:SKSpriteNode!
    var skyColor:SKColor!
    var coralTextureUp:SKTexture!
    var coralTextureDown:SKTexture!
    var movePipesAndRemove:SKAction!
    var moving:SKNode!
    var pipes:SKNode!
    var canRestart = Bool()
    var scoreLabelNode:SKLabelNode!
    var scoreLabelNode2:SKLabelNode!
    var pipeDown: SKSpriteNode!
    
    let platyCategory: UInt32 = 1 << 0
    let platy2Category: UInt32 = 1 << 1
    let worldCategory: UInt32 = 1 << 2
    let pipeCategory: UInt32 = 1 << 3
    let scoreCategory: UInt32 = 1 << 4
    let scoreCategory2: UInt32 = 1 << 5
    private var activeTouches = [UITouch:String]()
    
    @ObservedObject var swimPlatyOO : SwimPlatyOO
    
    init(size: CGSize, swimPlatyOO: SwimPlatyOO) {
            self.swimPlatyOO = swimPlatyOO
            super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        view.isMultipleTouchEnabled = true
        canRestart = true
        
        self.physicsWorld.gravity = CGVector( dx: 0.0, dy: -5.0 )
        self.physicsWorld.contactDelegate = self
        
        skyColor = SKColor(red: 174.0/255.0, green: 228.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        self.backgroundColor = skyColor
        
        moving = SKNode()
        self.addChild(moving)
        pipes = SKNode()
        moving.addChild(pipes)
        moving.speed = 0
        
        let skyTexture = SKTexture(imageNamed: "Flappy_Background")
        skyTexture.filteringMode = .nearest
        
        let moveSkySprite = SKAction.moveBy(x: -skyTexture.size().width * 2.0, y: 0, duration: TimeInterval(0.1 * skyTexture.size().width * 2.0))
        let resetSkySprite = SKAction.moveBy(x: skyTexture.size().width * 2.0, y: 0, duration: 0.0)
        let moveSkySpritesForever = SKAction.repeatForever(SKAction.sequence([moveSkySprite,resetSkySprite]))
        
        for i in 0 ..< 2 + Int(self.frame.size.width / ( skyTexture.size().width * 2 )) {
            let i = CGFloat(i)
            let sprite = SKSpriteNode(texture: skyTexture)
            sprite.setScale(0.35)
            sprite.zPosition = -20
            sprite.position = CGPoint(x: i * sprite.size.width, y: sprite.size.height/2)
            sprite.run(moveSkySpritesForever)
            moving.addChild(sprite)
        }
        
        coralTextureUp = SKTexture(imageNamed: "Flappy_Coral_Up")
        coralTextureUp.filteringMode = .nearest
        coralTextureDown = SKTexture(imageNamed: "Flappy_Coral_Down")
        coralTextureDown.filteringMode = .nearest
        
        let distanceToMove = CGFloat(self.frame.size.width + 2.0 * coralTextureUp.size().width)
        let movePipes = SKAction.moveBy(x: -distanceToMove, y:0.0, duration:TimeInterval(0.01 * distanceToMove))
        let removePipes = SKAction.removeFromParent()
        movePipesAndRemove = SKAction.sequence([movePipes, removePipes])
        
        let spawn = SKAction.run(spawnPipes)
        let delay = SKAction.wait(forDuration: TimeInterval(2.0))
        let spawnThenDelay = SKAction.sequence([spawn, delay])
        let spawnThenDelayForever = SKAction.repeatForever(spawnThenDelay)
        self.run(spawnThenDelayForever)
        
        let birdTexture1 = SKTexture(imageNamed: "flappy-plat")
        birdTexture1.filteringMode = .nearest
        
        platy = SKSpriteNode(texture: birdTexture1)
        
        platy.position = CGPoint(x: self.frame.size.width * 0.35, y:self.frame.size.height * 0.6)
        
        
        platy.physicsBody = SKPhysicsBody(circleOfRadius: platy.size.height / 2.0)
        platy.physicsBody?.isDynamic = false
        platy.physicsBody?.allowsRotation = false
        
        platy.physicsBody?.categoryBitMask = platyCategory
        platy.physicsBody?.collisionBitMask = worldCategory | pipeCategory
        platy.physicsBody?.contactTestBitMask = worldCategory | pipeCategory
        
        self.addChild(platy)
        
        let birdTexture2 = SKTexture(imageNamed: "Flappy_Puggle")
        birdTexture2.filteringMode = .nearest
        platy2 = SKSpriteNode(texture: birdTexture2)
        
        platy2.position = CGPoint(x: self.frame.size.width * 0.35, y:self.frame.size.height * 0.5)
        
        
        platy2.physicsBody = SKPhysicsBody(circleOfRadius: platy2.size.height / 2.0)
        platy2.physicsBody?.isDynamic = false
        platy2.physicsBody?.allowsRotation = false
        
        platy2.physicsBody?.categoryBitMask = platy2Category
        platy2.physicsBody?.collisionBitMask = worldCategory | pipeCategory
        platy2.physicsBody?.contactTestBitMask = worldCategory | pipeCategory
        
        self.addChild(platy2)
        
        let ground = SKShapeNode(rect: CGRect(x: 0, y: -5, width: self.frame.width, height: 1))
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width, height: 1))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = worldCategory
        ground.alpha = 0
        self.addChild(ground)
        
        let upper = SKShapeNode(rect: CGRect(x: 0, y: -5, width: self.frame.width, height: 0.01))
        upper.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width, height: 0.01))
        upper.physicsBody?.isDynamic = false
        upper.physicsBody?.categoryBitMask = worldCategory
        upper.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height+1)
        upper.alpha = 0
        self.addChild(upper)
        
        platyScore = SKSpriteNode(texture: birdTexture1)
        scoreLabelNode = SKLabelNode(fontNamed:AppFont.bold)
        platyScore.position = CGPoint( x: self.frame.midX/4+5, y: 3 * self.frame.size.height / 4 + 15 )
        scoreLabelNode.position = CGPoint( x: self.frame.midX/2, y: 3 * self.frame.size.height / 4 )
        scoreLabelNode.zPosition = 100
        platyScore.zPosition = 100
        platyScore.setScale(0.4)
        scoreLabelNode.text = String(swimPlatyOO.scorePlaty)
        self.addChild(scoreLabelNode)
        self.addChild(platyScore)
        
        platy2Score = SKSpriteNode(texture: birdTexture2)
        scoreLabelNode2 = SKLabelNode(fontNamed:AppFont.bold)
        scoreLabelNode2.position = CGPoint( x: self.frame.midX*3/2, y: 3 * self.frame.size.height / 4 )
        platy2Score.position = CGPoint( x: self.frame.midX*3/2-40, y: 3 * self.frame.size.height / 4 + 15)
        scoreLabelNode2.zPosition = 100
        platy2Score.zPosition = 100
        platy2Score.setScale(0.4)
        scoreLabelNode2.text = String(swimPlatyOO.scorePuggle)
        self.addChild(scoreLabelNode2)
        self.addChild(platy2Score)
        
    }
    
    func spawnPipes() {
        if swimPlatyOO.startGame && swimPlatyOO.firstTap{
            
            let pipePair = SKNode()
            pipePair.position = CGPoint( x: self.frame.size.width + coralTextureUp.size().width * 2, y: 0 )
            pipePair.zPosition = -10
            
            let height = UInt32( self.frame.size.height / 10)
            let y = Double(arc4random_uniform(height) + height)
            
            pipeDown = SKSpriteNode(texture: coralTextureDown)
            pipeDown.position = CGPoint(x: 0.0, y: y + Double(pipeDown.size.height) + verticalPipeGap)
            
            pipeDown.physicsBody = SKPhysicsBody(rectangleOf: pipeDown.size)
            pipeDown.physicsBody?.isDynamic = false
            pipeDown.physicsBody?.categoryBitMask = pipeCategory
            pipeDown.physicsBody?.contactTestBitMask = platyCategory | platy2Category
            pipePair.addChild(pipeDown)
            
            let pipeUp = SKSpriteNode(texture: coralTextureUp)
            
            pipeUp.position = CGPoint(x: 0.0, y: y)
            
            pipeUp.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size)
            pipeUp.physicsBody?.isDynamic = false
            pipeUp.physicsBody?.categoryBitMask = pipeCategory
            pipeUp.physicsBody?.contactTestBitMask = platyCategory | platy2Category
            pipePair.addChild(pipeUp)
            
            let contactNode = SKNode()
            contactNode.position = CGPoint( x: pipeDown.size.width + platy.size.width / 2, y: self.frame.midY )
            contactNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize( width: pipeUp.size.width, height: self.frame.size.height ))
            contactNode.physicsBody?.isDynamic = false
            contactNode.physicsBody?.categoryBitMask = scoreCategory
            contactNode.physicsBody?.contactTestBitMask = platyCategory
            pipePair.addChild(contactNode)
            
            let contactNode2 = SKNode()
            contactNode2.position = CGPoint( x: pipeDown.size.width + platy.size.width / 2, y: self.frame.midY )
            contactNode2.physicsBody = SKPhysicsBody(rectangleOf: CGSize( width: pipeUp.size.width, height: self.frame.size.height ))
            contactNode2.physicsBody?.isDynamic = false
            contactNode2.physicsBody?.categoryBitMask = scoreCategory2
            contactNode2.physicsBody?.contactTestBitMask = platy2Category
            pipePair.addChild(contactNode2)
            
            pipePair.run(movePipesAndRemove)
            pipes.addChild(pipePair)
        }
        
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if(location.x < self.size.width/2 && platyAlive){
                if moving.speed > 0  {
                    for _ in touches {
                        platy.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                        platy.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
                    }
                }
            }
            
            if(location.x > self.size.width/2 && platy2Alive){
                if moving.speed > 0  {
                    for _ in touches {
                        platy2.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                        platy2.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
                    }
                }
            }
            if swimPlatyOO.startGame && platyAlive && platy2Alive{
                swimPlatyOO.firstTap = true
                moving.speed = 1
                platy2.physicsBody?.isDynamic = true
                platy.physicsBody?.isDynamic = true
            }
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        let value = platy.physicsBody!.velocity.dy * ( platy.physicsBody!.velocity.dy < 0 ? 0.003 : 0.001 )
        platy.zRotation = min( max(-1, value), 0.5 )
        
        let value2 = platy2.physicsBody!.velocity.dy * ( platy2.physicsBody!.velocity.dy < 0 ? 0.003 : 0.001 )
        platy2.zRotation = min( max(-1, value2), 0.5 )
        
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        if moving.speed > 0 {
            if ( contact.bodyA.categoryBitMask & scoreCategory ) == scoreCategory || ( contact.bodyB.categoryBitMask & scoreCategory ) == scoreCategory && platyAlive {
                swimPlatyOO.scorePlaty += 1
                scoreLabelNode.text = String(swimPlatyOO.scorePlaty)
                
                scoreLabelNode.run(SKAction.sequence([SKAction.scale(to: 1.5, duration:TimeInterval(0.1)), SKAction.scale(to: 1.0, duration:TimeInterval(0.1))]))
            }else if contact.bodyA.categoryBitMask == platyCategory || contact.bodyB.categoryBitMask == platyCategory && platyAlive {
                platyAlive = false
                
                platy.run(  SKAction.rotate(byAngle: CGFloat(Double.pi) * CGFloat(platy.position.y) * 0.01, duration:1), completion:{self.platy.speed = 0 })
                
                self.run(SKAction.sequence([SKAction.repeat(SKAction.sequence([SKAction.run({
                    self.backgroundColor = SKColor(red: 1, green: 0, blue: 0, alpha: 1.0)
                }),SKAction.wait(forDuration: TimeInterval(0.05)), SKAction.run({
                    self.backgroundColor = self.skyColor
                }), SKAction.wait(forDuration: TimeInterval(0.05))]), count:4), SKAction.run({
                    self.canRestart = true
                })]), withKey: "flash")
            }
            
            if ( contact.bodyA.categoryBitMask & scoreCategory2 ) == scoreCategory2 || ( contact.bodyB.categoryBitMask & scoreCategory2 ) == scoreCategory2 && platy2Alive{
                swimPlatyOO.scorePuggle += 1
                scoreLabelNode2.text = String(swimPlatyOO.scorePuggle)
                
                scoreLabelNode2.run(SKAction.sequence([SKAction.scale(to: 1.5, duration:TimeInterval(0.1)), SKAction.scale(to: 1.0, duration:TimeInterval(0.1))]))
            }else if contact.bodyA.categoryBitMask == platy2Category || contact.bodyB.categoryBitMask == platy2Category && platy2Alive{
                platy2Alive = false
                
                platy2.run(  SKAction.rotate(byAngle: CGFloat(Double.pi) * CGFloat(platy2.position.y) * 0.01, duration:1), completion:{self.platy2.speed = 0 })
                self.run(SKAction.sequence([SKAction.repeat(SKAction.sequence([SKAction.run({
                    self.backgroundColor = SKColor(red: 1, green: 0, blue: 0, alpha: 1.0)
                }),SKAction.wait(forDuration: TimeInterval(0.05)), SKAction.run({
                    self.backgroundColor = self.skyColor
                }), SKAction.wait(forDuration: TimeInterval(0.05))]), count:4), SKAction.run({
                    self.canRestart = true
                })]), withKey: "flash")
                
            }
            
            if platy2Alive == false && platyAlive == false {
                moving.speed = 0
                platy.physicsBody?.collisionBitMask = worldCategory
                platy2.physicsBody?.collisionBitMask = worldCategory
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                    self.swimPlatyOO.gameOver = true
                    }
            }
            
            
        }
    }
}


class SwimPlatyOO: ObservableObject {
    @Published var startGame: Bool = true
    @Published var firstTap: Bool = false
    @Published var scorePlaty: Int = 0
    @Published var scorePuggle: Int = 0
    @Published var gameOver: Bool = false
}

struct SwimPlatypusView: View {
    @StateObject var swimPlatyOO = SwimPlatyOO()
    var body: some View {
        ZStack {
            if !swimPlatyOO.gameOver {
                ZStack{
                    GeometryReader { geometry in
                        SpriteView(scene: SwimPlatypusScene(size: CGSize(width: geometry.size.width, height: geometry.size.height), swimPlatyOO: swimPlatyOO), options: [.allowsTransparency])
                    }
                    .edgesIgnoringSafeArea(.all)
                    if swimPlatyOO.startGame && !swimPlatyOO.firstTap{
                        HStack (spacing: 100){
                            VStack {
                                Text("Tap here to move Platypus")
                                    .font(.custom(AppFont.bold, size: 16))
                                .foregroundColor(AppColor.navy)
                                .frame(width: 100)
                                .multilineTextAlignment(.center)
                                .allowsHitTesting(false)
                            .offset(y: 200)
                                Image("flappy-plat")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(y: 200)
                                    .frame(width: 70)
                            }
                            
                        
                            VStack {
                                Text("Tap here to move Puggle")
                                    .font(.custom(AppFont.bold, size: 16))
                                .foregroundColor(AppColor.navy)
                                .frame(width: 100)
                                .multilineTextAlignment(.center)
                                .allowsHitTesting(false)
                            .offset(y: 200)
                                Image("Flappy_Puggle")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(y: 200)
                                    .frame(width: 70)
                            }
                        
                        }
                    }
                    PopUpReadySetGo(start: $swimPlatyOO.startGame, potrait: true)
                        .opacity($swimPlatyOO.startGame.wrappedValue ? 0.0 : 1.0)
                }
            }else{
                GameResultView(scorePlaty: swimPlatyOO.scorePlaty, scorePuggle: swimPlatyOO.scorePuggle, playAgain: AnyView(SwimPlatypusView()), game: 0)
            }
        }
    }
}


struct SwimPlatypus_Previews: PreviewProvider {
    static var previews: some View {
        SwimPlatypusView()
    }
}
