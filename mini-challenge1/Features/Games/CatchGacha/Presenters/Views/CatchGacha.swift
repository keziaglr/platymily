//
//  CatchGacha.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 24/04/23.
//

import SwiftUI
import SpriteKit

struct PhysicsCategory {
    static let player: UInt32 = 1 << 0
    static let player2: UInt32 = 1 << 1
    static let bread: UInt32 = 1 << 2
    static let rock: UInt32 = 1 << 3
}

class CatchGachaScene: SKScene, SKPhysicsContactDelegate {
    @ObservedObject var catchGachaOO : CatchGachaOO
    let playerTexture = SKTexture(imageNamed: "Holding_Basket")
    let player2Texture = SKTexture(imageNamed: "Puggle_Basket")
    let hearthTexture = SKTexture(imageNamed: "Platypus")
    let hearth2Texture = SKTexture(imageNamed: "Puggle")
    var player: SKSpriteNode!
    var player2: SKSpriteNode!
    var ground: SKSpriteNode!
    var bom: SKSpriteNode!
    var gacha: SKSpriteNode!
    var bread2: SKSpriteNode!
    var hearth1: SKSpriteNode!
    var hearth2: SKSpriteNode!
    var hearth3: SKSpriteNode!
    var hearth21: SKSpriteNode!
    var hearth22: SKSpriteNode!
    var hearth23: SKSpriteNode!
    var playerAlive = true
    var player2Alive = true
    var highscore = 0
    let scoreLabel = SKLabelNode(text: "0")
    let scoreLabel2 = SKLabelNode(text: "0")
    init(size: CGSize, catchGachaOO: CatchGachaOO) {
            self.catchGachaOO = catchGachaOO
            super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createGround(){
        ground = SKSpriteNode(imageNamed: "Ground")
        ground.size = CGSize(width: size.height+20, height: ground.size.height/2)
        ground.position = CGPoint(x: size.width, y: size.width+35)
        ground.zRotation = CGFloat.pi/2
        addChild(ground)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: size.height/2))
        path.addLine(to: CGPoint(x: size.width, y: size.height/2))
        let line = SKShapeNode(path: path.cgPath)
        line.strokeColor = .white
        line.lineWidth = 4

        let linePhysicsBody = SKPhysicsBody(edgeChainFrom: path.cgPath)
        line.physicsBody = linePhysicsBody
        line.physicsBody?.isDynamic = false
        addChild(line)

    }

    func createPlayer(){
        player = SKSpriteNode(texture: playerTexture, size: CGSize(width: 100, height: 100))
        player.position = CGPoint(x: size.width*3/4+30, y: size.height/4)
        player.zRotation = CGFloat.pi/2
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.bread | PhysicsCategory.rock
        player.physicsBody?.collisionBitMask = 0
        addChild(player)
        
        player2 = SKSpriteNode(texture: player2Texture, size: CGSize(width: 100, height: 100))
        player2.position = CGPoint(x: size.width*3/4+30, y: size.height*3/4)
        player2.zRotation = CGFloat.pi/2
        player2.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player2.physicsBody?.affectedByGravity = false
        player2.physicsBody?.isDynamic = true
        player2.physicsBody?.allowsRotation = false
        player2.physicsBody?.categoryBitMask = PhysicsCategory.player2
        player2.physicsBody?.contactTestBitMask = PhysicsCategory.bread | PhysicsCategory.rock
        player2.physicsBody?.collisionBitMask = 0
        addChild(player2)
    }
    
    func createHearth() {
        hearth1 = SKSpriteNode(texture: hearthTexture, size: CGSize(width: 25, height: 25))
        hearth1.position = CGPoint(x: 20, y: frame.midY / 2 - 30)
        hearth1.zRotation = CGFloat.pi * 0.5
        hearth2 = SKSpriteNode(texture: hearthTexture, size: CGSize(width: 25, height: 25))
        hearth2.position = CGPoint(x: 20, y: frame.midY / 2)
        hearth2.zRotation = CGFloat.pi * 0.5
        hearth3 = SKSpriteNode(texture: hearthTexture, size: CGSize(width: 25, height: 25))
        hearth3.position = CGPoint(x: 20, y: frame.midY / 2 + 30)
        hearth3.zRotation = CGFloat.pi * 0.5
        addChild(hearth1)
        addChild(hearth2)
        addChild(hearth3)
        
        hearth21 = SKSpriteNode(texture: hearth2Texture, size: CGSize(width: 25, height: 25))
        hearth21.position = CGPoint(x: 20, y: frame.midY * 3 / 2 - 30)
        hearth21.zRotation = CGFloat.pi * 0.5
        hearth22 = SKSpriteNode(texture: hearth2Texture, size: CGSize(width: 25, height: 25))
        hearth22.position = CGPoint(x: 20, y: frame.midY * 3 / 2)
        hearth22.zRotation = CGFloat.pi * 0.5
        hearth23 = SKSpriteNode(texture: hearth2Texture, size: CGSize(width: 25, height: 25))
        hearth23.position = CGPoint(x: 20, y: frame.midY * 3 / 2 + 30)
        hearth23.zRotation = CGFloat.pi * 0.5
        addChild(hearth21)
        addChild(hearth22)
        addChild(hearth23)
    }
    
    func createRock(testing: Bool) {
        let rockTexture = SKTexture(imageNamed: "Bomb")
        bom = SKSpriteNode(texture: rockTexture)
        bom.size = CGSize(width: 30, height: 30)
        let randomY = testing ? CGFloat.random(in: bom.size.width...size.height/2 - bom.size.width) : CGFloat.random(in: size.height/2+bom.size.width...size.height - bom.size.width)
        bom.zRotation = CGFloat.pi/2
        bom.position = CGPoint(x: 0, y: randomY)
        bom.physicsBody = SKPhysicsBody(rectangleOf: bom.size)
        bom.physicsBody?.categoryBitMask = PhysicsCategory.rock
        bom.physicsBody?.contactTestBitMask = PhysicsCategory.player2 | PhysicsCategory.player
        bom.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
        bom.physicsBody?.linearDamping = 10

        if catchGachaOO.startGame && catchGachaOO.firstTap{
            if testing && playerAlive{
                addChild(bom)
            }else if !testing && player2Alive{
                addChild(bom)
            }
        }
    }
    
    func createBread(testing: Bool) {
        let breadTexture = SKTexture(imageNamed: "Gacha")
        gacha = SKSpriteNode(texture: breadTexture)
        gacha.name = "bread"
        gacha.size = CGSize(width: 30, height: 30)
        let randomY = testing ? CGFloat.random(in: gacha.size.width...size.height/2 - gacha.size.width) : CGFloat.random(in: size.height/2+gacha.size.width...size.height - gacha.size.width)
        gacha.position = CGPoint(x: 0, y: randomY)
        gacha.zRotation = CGFloat.pi/2
        gacha.physicsBody = SKPhysicsBody(rectangleOf: gacha.size)
        gacha.physicsBody?.categoryBitMask = PhysicsCategory.bread
        gacha.physicsBody?.contactTestBitMask = PhysicsCategory.player | PhysicsCategory.player2
        gacha.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
        gacha.physicsBody?.linearDamping = 10

        if catchGachaOO.startGame && catchGachaOO.firstTap{
            if testing && playerAlive{
                addChild(gacha)
            }else if !testing && player2Alive{
                addChild(gacha)
            }
        }

    }

    func createScore(){
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY / 2)
        scoreLabel.fontColor = UIColor.white
        scoreLabel.fontName = AppFont.bold
        scoreLabel.zRotation = CGFloat.pi * 0.5
        addChild(scoreLabel)
        
        scoreLabel2.position = CGPoint(x: frame.midX, y: frame.midY * 3 / 2)
        scoreLabel2.fontColor = UIColor.white
        scoreLabel2.fontName = AppFont.bold
        scoreLabel2.zRotation = CGFloat.pi * 0.5
        addChild(scoreLabel2)
    }
    
    override func didMove(to view: SKView) {
        view.isMultipleTouchEnabled = true
        physicsWorld.gravity = CGVector(dx: 9.8, dy: 0)
        
        let bg = SKSpriteNode(imageNamed: "Background")
        bg.setScale(0.25)
        bg.zPosition = -20
        bg.position = .init(x: self.frame.width/2, y: self.frame.height/2)
        self.addChild(bg)
        
        let waitAction = SKAction.wait(forDuration: 0.7)
        let waitAction5s = SKAction.wait(forDuration: 2)
        
        let createRockAction = SKAction.run {
            self.createRock(testing: true)
            self.createRock(testing: false)
        }
        let sequenceAction = SKAction.sequence([createRockAction, waitAction5s])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        run(repeatAction)
        
        let createBreadAction = SKAction.run {
            self.createBread(testing: true)
            self.createBread(testing: false)
        }
        let sequenceActionBread = SKAction.sequence([createBreadAction, waitAction])
        let repeatActionBread = SKAction.repeatForever(sequenceActionBread)
        
        run(repeatActionBread)
        
        createGround()
        createPlayer()
        createHearth()
        createScore()
        
        physicsWorld.contactDelegate = self

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == PhysicsCategory.player && contact.bodyB.categoryBitMask == PhysicsCategory.bread {
            contact.bodyB.node?.removeFromParent()
            if playerAlive{
                catchGachaOO.scorePlaty += 1
            }
        }
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.player2 && contact.bodyB.categoryBitMask == PhysicsCategory.bread{
            contact.bodyB.node?.removeFromParent()
            if player2Alive{
                catchGachaOO.scorePuggle += 1
            }
        }
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.player && contact.bodyB.categoryBitMask == PhysicsCategory.rock {
            contact.bodyB.node?.removeFromParent()
            
            if hearth3.parent != nil {
                hearth3.removeFromParent()
            } else if hearth2.parent != nil {
                hearth2.removeFromParent()
            } else if hearth1.parent != nil {
                hearth1.removeFromParent()
                playerAlive = false
            }
        }
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.player2 && contact.bodyB.categoryBitMask == PhysicsCategory.rock {
            contact.bodyB.node?.removeFromParent()
            
            if hearth23.parent != nil {
                hearth23.removeFromParent()
            } else if hearth22.parent != nil {
                hearth22.removeFromParent()
            } else if hearth21.parent != nil {
                hearth21.removeFromParent()
                player2Alive = false
                
            }
        }
        
        if playerAlive{
            scoreLabel.text = "\(catchGachaOO.scorePlaty)"
        }else{
            scoreLabel.text = "GAME OVER"
        }
        
        if player2Alive{
            scoreLabel2.text = "\(catchGachaOO.scorePuggle)"
        }else{
            scoreLabel2.text = "GAME OVER"
        }
        
        
        if !playerAlive && !player2Alive{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                self.catchGachaOO.gameOver = true
                }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            catchGachaOO.firstTap = true
            
            if(location.y < self.size.height/2 - 50){
                player.position.y = location.y
            }
            
            if(location.y > self.size.height/2 + 50){
                player2.position.y = location.y
            }
        }
    }

}

class CatchGachaOO: ObservableObject {
    @Published var startGame: Bool = false
    @Published var firstTap: Bool = false
    @Published var scorePlaty: Int = 0
    @Published var scorePuggle: Int = 0
    @Published var gameOver: Bool = false
}

struct CatchGacha: View {
    @StateObject var catchGacha = CatchGachaOO()
    var body: some View {
        ZStack {
            if !catchGacha.gameOver {
                ZStack{
                    GeometryReader { geometry in
                        SpriteView(scene: CatchGachaScene(size: CGSize(width: geometry.size.width, height: geometry.size.height), catchGachaOO: catchGacha), options: [.allowsTransparency])
                    }
                    .edgesIgnoringSafeArea(.all)
                    PopUpReadySetGo(start: $catchGacha.startGame, potrait: false)
                        .opacity($catchGacha.startGame.wrappedValue ? 0.0 : 1.0)
                    if catchGacha.startGame && !catchGacha.firstTap{
                        HStack (spacing: 75){
                            Text("Drag Platypus to move")
                                .font(.custom(AppFont.bold, size: 16))
                                .foregroundColor(AppColor.navy)
                                .multilineTextAlignment(.center)
                                .allowsHitTesting(false)
                                .frame(width: 120)
                            
                            Text("Drag Puggle to move")
                                .font(.custom(AppFont.bold, size: 16))
                                .foregroundColor(AppColor.navy)
                                .frame(width: 120)
                                .multilineTextAlignment(.center)
                                .allowsHitTesting(false)
                        }.rotationEffect(.degrees(270))
                    }
                }
            }else{
                GameResultView(scorePlaty: catchGacha.scorePlaty, scorePuggle: catchGacha.scorePuggle, playAgain: AnyView(CatchGacha()), game: 3)
            }
        }
    }
}


struct CatchGacha_Previews: PreviewProvider {
    static var previews: some View {
        CatchGacha()
    }
}
