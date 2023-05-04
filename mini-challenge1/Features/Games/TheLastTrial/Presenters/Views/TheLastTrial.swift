//
//  TheLastTrial.swift
//  mini-challenge1
//
//  Created by Nicholas Yvees on 02/05/23.
//

import SwiftUI
import SpriteKit

class TheLastTrialScene: SKScene, SKPhysicsContactDelegate {
    
    @ObservedObject var lastTrial00 : LastTrial00
    
    let characterTexture = SKTexture(imageNamed: "TheLastTrial_Platy")
    let character2Texture = SKTexture(imageNamed: "Flappy_Puggle")
    let bossTexture = SKTexture(imageNamed: "Snake")
    let snakeVenomTexture = SKTexture(imageNamed: "Snake_Venom")
    let bubbleTexture = SKTexture(imageNamed: "Bubble")
    var character: SKSpriteNode!
    var boss: SKSpriteNode!
    var bossBullet: SKSpriteNode!
    var characterBullet: SKSpriteNode!
    
    var characterHealth: Int = 3
    var score: Int = 0
    
    var healthLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    
    var isCharacterHit: Bool = false
    var isBossHit: Bool = false
    
    var frameSinceBossBulletLastSpawn = 0
    var frameSinceCharacterBulletLastSpawn = 0
    
    let characterCategory: UInt32 = 0x1 << 0
    let bossProjectileCategory: UInt32 = 0x1 << 1
    let bossCategory: UInt32 = 0x1 << 2
    let characterProjectileCategory: UInt32 = 0x1 << 3
    
    init(size: CGSize, lastTrial00: LastTrial00) {
            self.lastTrial00 = lastTrial00
            super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func characterHit(){
        if !isCharacterHit {
            
            if characterHealth > 0{
                characterHealth -= 1
                isCharacterHit = true
                
                if characterHealth == 0{
                    if lastTrial00.platyTurn == true{
                        lastTrial00.platyTurn = false
                        lastTrial00.showPopup = true
                        characterHealth = 3
                        character.removeFromParent()
                        healthLabel.removeFromParent()
                        scoreLabel.removeFromParent()
                        createCharacter()
                        createInformationInterface()
//                        scoreLabel.text = "Score: \(lastTrial00.platyTurn ? lastTrial00.scorePlaty : lastTrial00.scorePuggle)"
                    }else{
                        lastTrial00.gameOver = true
                    }
                }
            }
            
            // Set a timer to reset isCharacterHit to false after 1 second
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                self.isCharacterHit = false
            }
            
            healthLabel.text = "Health: \(characterHealth)"
            
        }
    }
    
    func puggleTurn(){
        lastTrial00.showPopup = true
        characterHealth = 3
        
    }
    
    func bossHit(){
        if !isBossHit {
            if lastTrial00.platyTurn == true{
                lastTrial00.scorePlaty += 10
            }else{
                lastTrial00.scorePuggle += 10
            }
            isBossHit = true
            
            // Set a timer to reset isCharacterHit to false after 1 second
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                self.isBossHit = false
            }
            if lastTrial00.platyTurn == true{
                scoreLabel.text = "Score: \(lastTrial00.scorePlaty)"
            }else{
                scoreLabel.text = "Score: \(lastTrial00.scorePuggle)"
            }
            
        }
    }
    
    func createInformationInterface(){
        healthLabel = SKLabelNode(fontNamed: AppFont.bold)
        healthLabel.fontSize = 20
        healthLabel.fontColor = SKColor.white
        healthLabel.text = "Health: \(characterHealth)"
        healthLabel.horizontalAlignmentMode = .left
        healthLabel.position = CGPoint(x: frame.minX + 50, y: frame.minY)
        healthLabel.zRotation = CGFloat.pi/2
        addChild(healthLabel)
        
        
        scoreLabel = SKLabelNode(fontNamed: AppFont.bold)
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = SKColor.white
        scoreLabel.text = "Score: \(lastTrial00.platyTurn ? lastTrial00.scorePlaty : lastTrial00.scorePuggle)"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: frame.minX + 70, y: frame.minY)
        scoreLabel.zRotation = CGFloat.pi/2
        addChild(scoreLabel)
    }
    
    func createCharacter(){
        // Create and add the character node to the scene
        
        character = SKSpriteNode(texture: lastTrial00.platyTurn ? characterTexture : character2Texture, size: CGSize(width: 100, height: 100))
        character.position = CGPoint(x: frame.midX, y: frame.midY)
        character.zRotation = CGFloat.pi/2
        character.physicsBody = SKPhysicsBody(texture: character.texture!, size: character.size)
        character.physicsBody!.affectedByGravity = false
        character.physicsBody!.isDynamic = true
        character.physicsBody!.categoryBitMask = characterCategory
        character.physicsBody!.contactTestBitMask = bossProjectileCategory
        character.physicsBody!.collisionBitMask = 0
        
        addChild(character)
        
    }
    
    func createBoss(){
        boss = SKSpriteNode(texture: bossTexture, size: CGSize(width: 350, height: 350))
        boss.position = CGPoint(x: size.width/2, y: size.height - boss.size.width/2)
        boss.zRotation = CGFloat.pi/2
        boss.physicsBody = SKPhysicsBody(texture: boss.texture!, size: boss.size)
        boss.physicsBody!.affectedByGravity = false
        boss.physicsBody!.isDynamic = true
        boss.physicsBody!.categoryBitMask = bossCategory
        boss.physicsBody!.contactTestBitMask = characterProjectileCategory
        boss.physicsBody!.collisionBitMask = 0
        
        addChild(boss)
    }
    
    func spawnBossProjectile() {
        // Create asset sprite node
        bossBullet = SKSpriteNode(texture: snakeVenomTexture, size: CGSize(width: 50, height: 50))
        
        // Set asset position on the right edge of the scene with a random y position
        let maxX = size.width - bossBullet.size.width/2
        let minX = bossBullet.size.width/2
        let rangeX = maxX - minX
        let randomX = CGFloat(arc4random_uniform(UInt32(rangeX))) + minX
        bossBullet.position = CGPoint(x: randomX, y: size.height + bossBullet.size.height/2)
        bossBullet.zRotation = CGFloat.pi/2
        bossBullet.physicsBody = SKPhysicsBody(rectangleOf: bossBullet.size)
        //        bossBullet.physicsBody = SKPhysicsBody(texture: bossBullet.texture!, size: bossBullet.size)
        bossBullet.physicsBody!.affectedByGravity = false
        bossBullet.physicsBody!.isDynamic = true
        bossBullet.physicsBody!.categoryBitMask = bossProjectileCategory
        bossBullet.physicsBody!.contactTestBitMask = characterCategory
        bossBullet.physicsBody!.collisionBitMask = 0
        
        // Add the asset to the scene
        if lastTrial00.startGame && lastTrial00.firstTap{
            addChild(bossBullet)
        }
        
        
        var projectileSpeed: CGFloat = 1000
        if lastTrial00.scorePlaty >= 150{
            projectileSpeed = 500
        } else if lastTrial00.scorePlaty >= 250{
            projectileSpeed = 250
        }
        
        // Set up SKAction to move the asset to the left edge of the scene
        let moveDuration = TimeInterval(4.0) // set duration of the movement
        let moveAction = SKAction.moveTo(y: -bossBullet.size.height/2, duration: TimeInterval(projectileSpeed / size.height * 2))
        
        // Remove the asset from the scene when it moves off the left edge
        let removeAction = SKAction.removeFromParent()
        let moveAndRemoveAction = SKAction.sequence([moveAction, removeAction])
        
        // Run the move and remove action on the asset node
        bossBullet.run(moveAndRemoveAction)
    }
    
    func spawnCharacterProjectile() {
        // Create a new asset node
        characterBullet = SKSpriteNode(texture: bubbleTexture, size: CGSize(width: 50, height: 50))
        
        // Set the position of the asset to be just to the right of the character's position
        let characterPosition = character.position
        let assetXPosition = characterPosition.x
        let assetYPosition = characterPosition.y + character.size.height/2 + characterBullet.size.height/2
        characterBullet.position = CGPoint(x: assetXPosition, y: assetYPosition)
        characterBullet.zRotation = CGFloat.pi/2
        characterBullet.physicsBody = SKPhysicsBody(rectangleOf: characterBullet.size)
        //        characterBullet.physicsBody = SKPhysicsBody(texture: characterBullet.texture!, size: characterBullet.size)
        characterBullet.physicsBody!.affectedByGravity = false
        characterBullet.physicsBody!.isDynamic = true
        characterBullet.physicsBody!.categoryBitMask = characterProjectileCategory
        characterBullet.physicsBody!.contactTestBitMask = bossCategory
        characterBullet.physicsBody!.collisionBitMask = 0
        
        // Add the asset node to the scene
        if lastTrial00.startGame && lastTrial00.firstTap{
            addChild(characterBullet)
        }
        
        
        // Calculate the duration of the asset's movement across the screen based on the speed constant
        let moveDuration = TimeInterval(2.0)
        
        // Create the action to move the asset across the screen, and remove it from the scene when it reaches the left edge
        let moveAction = SKAction.moveTo(y: size.height + characterBullet.size.height/2, duration: moveDuration)
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveAction, removeAction])
        characterBullet.run(sequence)
    }
    
    
    override func didMove(to view: SKView) {
        
        // Create the two background nodes
        let bg1 = SKSpriteNode(imageNamed: "TheLastTrial_Background")
        bg1.setScale(0.5)
        let bg2 = SKSpriteNode(imageNamed: "TheLastTrial_Background")
        bg2.setScale(0.5)
        
        // Set the initial positions of the background nodes
        bg1.position = CGPoint(x: frame.midX, y: frame.midY)
        bg2.position = CGPoint(x: frame.midX, y: bg1.position.y + bg1.size.height)
        
        bg1.zRotation = CGFloat.pi/2
        bg2.zRotation = CGFloat.pi/2
        
        // Add the background nodes to the scene
        addChild(bg1)
        addChild(bg2)
        
        // Create the scrolling actions
        let moveUp = SKAction.moveBy(x: 0, y: -bg1.size.height, duration: 10)
        let reset = SKAction.moveBy(x: 0, y: bg1.size.height, duration: 0)
        let sequence = SKAction.sequence([moveUp, reset])
        let repeatForever = SKAction.repeatForever(sequence)
        
        // Run the scrolling actions on both background nodes
        bg1.run(repeatForever)
        bg2.run(repeatForever)
        
        createCharacter()
        createBoss()
        createInformationInterface()
        
        physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // Check if the contact is between the character and bossProjectile
        if (contact.bodyA.categoryBitMask == characterCategory && contact.bodyB.categoryBitMask == bossProjectileCategory) ||
            (contact.bodyA.categoryBitMask == bossProjectileCategory && contact.bodyB.categoryBitMask == characterCategory) {
            
            // Remove the bossProjectile from the scene
            if contact.bodyA.categoryBitMask == bossProjectileCategory {
                contact.bodyA.node?.removeFromParent()
            } else {
                contact.bodyB.node?.removeFromParent()
            }
            
            characterHit()
            
        } else if (contact.bodyA.categoryBitMask == characterProjectileCategory && contact.bodyB.categoryBitMask == bossCategory) ||
                    (contact.bodyA.categoryBitMask == bossCategory && contact.bodyB.categoryBitMask == characterProjectileCategory) {
            
            // Remove the bossProjectile from the scene
            if contact.bodyA.categoryBitMask == characterProjectileCategory {
                contact.bodyA.node?.removeFromParent()
            } else {
                contact.bodyB.node?.removeFromParent()
            }
            
            bossHit()
            
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            lastTrial00.firstTap = true
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            let translation = CGPoint(x: location.x - previousLocation.x, y: location.y - previousLocation.y)
            
            var newPosition = CGPoint(x: character.position.x + translation.x, y: character.position.y + translation.y)
            
            // Keep the character within the visible area
            let halfWidth = character.size.width/2
            let halfHeight = character.size.height/2
            newPosition.x = max(halfWidth, min(newPosition.x, size.width - halfWidth))
            newPosition.y = max(halfHeight, min(newPosition.y, size.height - halfHeight))
            
            character.position = newPosition
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        let spawnInterval = 120
        
        frameSinceBossBulletLastSpawn += 1
        frameSinceCharacterBulletLastSpawn += 1
        
        if frameSinceBossBulletLastSpawn >= spawnInterval && lastTrial00.scorePlaty < 100 && lastTrial00.platyTurn == true {
            frameSinceBossBulletLastSpawn = 0
            spawnBossProjectile()
        } else if frameSinceBossBulletLastSpawn >= spawnInterval && lastTrial00.scorePlaty >= 100 && lastTrial00.scorePlaty < 200 && lastTrial00.platyTurn == true{
            frameSinceBossBulletLastSpawn = 0
            spawnBossProjectile()
            spawnBossProjectile()
        } else if frameSinceBossBulletLastSpawn >= spawnInterval && lastTrial00.scorePlaty >= 200 && lastTrial00.scorePlaty < 250 && lastTrial00.platyTurn == true{
            frameSinceBossBulletLastSpawn = 60
            spawnBossProjectile()
            spawnBossProjectile()
            spawnBossProjectile()
        } else if frameSinceBossBulletLastSpawn >= spawnInterval && lastTrial00.scorePlaty >= 250 && lastTrial00.platyTurn == true{
            frameSinceBossBulletLastSpawn = 60
            spawnBossProjectile()
            spawnBossProjectile()
            spawnBossProjectile()
            spawnBossProjectile()
        }
        
        if frameSinceBossBulletLastSpawn >= spawnInterval && lastTrial00.scorePuggle < 100 && lastTrial00.platyTurn == false {
            frameSinceBossBulletLastSpawn = 0
            spawnBossProjectile()
        } else if frameSinceBossBulletLastSpawn >= spawnInterval && lastTrial00.scorePuggle >= 100 && lastTrial00.scorePuggle < 200 && lastTrial00.platyTurn == false{
            frameSinceBossBulletLastSpawn = 0
            spawnBossProjectile()
            spawnBossProjectile()
        } else if frameSinceBossBulletLastSpawn >= spawnInterval && lastTrial00.scorePuggle >= 200 && lastTrial00.scorePuggle < 250 && lastTrial00.platyTurn == false{
            frameSinceBossBulletLastSpawn = 60
            spawnBossProjectile()
            spawnBossProjectile()
            spawnBossProjectile()
        } else if frameSinceBossBulletLastSpawn >= spawnInterval && lastTrial00.scorePuggle >= 250 && lastTrial00.platyTurn == false{
            frameSinceBossBulletLastSpawn = 60
            spawnBossProjectile()
            spawnBossProjectile()
            spawnBossProjectile()
            spawnBossProjectile()
        }
        
        if frameSinceCharacterBulletLastSpawn >= spawnInterval{
            frameSinceCharacterBulletLastSpawn = 0
            spawnCharacterProjectile()
        }
    }
}

class LastTrial00: ObservableObject{
    @Published var startGame: Bool = false
    @Published var firstTap: Bool = false
    @Published var scorePlaty: Int = 0
    @Published var scorePuggle: Int = 0
    @Published var gameOver: Bool = false
    @Published var platyTurn: Bool = true
    @Published var showPopup: Bool = true
}

struct TheLastTrial: View {
    @StateObject var lastTrial = LastTrial00()
    @ObservedObject var mc : MusicController
    var body: some View {
        if !lastTrial.gameOver {
            ZStack{
                GeometryReader { geometry in
                    SpriteView(scene: TheLastTrialScene(size: CGSize(width: geometry.size.width, height: geometry.size.height), lastTrial00: lastTrial), options: [.allowsTransparency])
                        .onAppear{
                            mc.playGameMusic()
                        }
                }
                .edgesIgnoringSafeArea(.all)
                PopUpReadySetGo(goOpacity: 0.2, start: $lastTrial.startGame, potrait: false)
                    .opacity($lastTrial.startGame.wrappedValue ? 0.0 : 1.0)
//                    .rotationEffect(.degrees())
                if lastTrial.startGame && !lastTrial.firstTap{
                    VStack (spacing: 75){
                        Text("Drag Platypus to move")
                            .font(.custom(AppFont.bold, size: 16))
                            .foregroundColor(AppColor.navy)
                            .multilineTextAlignment(.center)
                            .allowsHitTesting(false)
                            .frame(width: 120)

                    }
                    .rotationEffect(.degrees(270))
                    .padding(.trailing, 100)
                }
                if lastTrial.showPopup{
                    PopUpGameTurn(platyTurn: lastTrial.platyTurn, potrait: false, showPopup: $lastTrial.showPopup)
                    
                }
            }
            .navigationBarBackButtonHidden(true)
        } else{
            GameResultView(scorePlaty: lastTrial.scorePlaty, scorePuggle: lastTrial.scorePuggle, playAgain: AnyView(TheLastTrial(mc: mc)), game: 5, mc: mc)
        }
    }
}

//struct TheLastTrial_Previews: PreviewProvider {
//    static var previews: some View {
//        TheLastTrial()
//    }
//}

