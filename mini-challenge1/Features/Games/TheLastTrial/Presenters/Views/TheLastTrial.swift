//
//  TheLastTrial.swift
//  mini-challenge1
//
//  Created by Nicholas Yvees on 02/05/23.
//

import SwiftUI
import SpriteKit
import GameplayKit

class TheLastTrialScene: SKScene, SKPhysicsContactDelegate {
    
    let characterTexture = SKTexture(imageNamed: "TheLastTrial_Platy")
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
    
    func characterHit(){
        if !isCharacterHit {
            characterHealth -= 1
            isCharacterHit = true
            
            // Set a timer to reset isCharacterHit to false after 1 second
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                self.isCharacterHit = false
            }
            
            healthLabel.text = "Health: \(characterHealth)"
            
            if characterHealth <= 0 {
//                gameOver()
            }
        }
    }
    
    func bossHit(){
        if !isBossHit {
            score += 10
            isBossHit = true
            
            // Set a timer to reset isCharacterHit to false after 1 second
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                self.isBossHit = false
            }
            
            scoreLabel.text = "Score: \(score)"
            
        }
    }
    
    func createInformationInterface(){
        healthLabel = SKLabelNode(fontNamed: "Helvetica")
        healthLabel.fontSize = 20
        healthLabel.fontColor = SKColor.white
        healthLabel.text = "Health: \(characterHealth)"
        healthLabel.horizontalAlignmentMode = .left
        healthLabel.position = CGPoint(x: frame.minX + 30, y: frame.maxY - 30)
        addChild(healthLabel)
        
        scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = SKColor.white
        scoreLabel.text = "Score: \(score)"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: frame.minX + 30, y: frame.maxY - 50)
        addChild(scoreLabel)
    }
    
    func createCharacter(){
        // Create and add the character node to the scene
        character = SKSpriteNode(texture: characterTexture, size: CGSize(width: 100, height: 100))
        character.position = CGPoint(x: frame.midX, y: frame.midY)
        
        character.physicsBody = SKPhysicsBody(texture: character.texture!, size: character.size)
        character.physicsBody!.affectedByGravity = false
        character.physicsBody!.isDynamic = true
        character.physicsBody!.categoryBitMask = characterCategory
        character.physicsBody!.contactTestBitMask = bossProjectileCategory
        character.physicsBody!.collisionBitMask = 0
        
        addChild(character)
        
    }
    
    func createBoss(){
        boss = SKSpriteNode(texture: bossTexture, size: CGSize(width: 400, height: 400))
        boss.position = CGPoint(x: size.width - boss.size.width/2, y: size.height/2)
        
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
        let maxY = size.height - bossBullet.size.height/2
        let minY = bossBullet.size.height/2
        let rangeY = maxY - minY
        let randomY = CGFloat(arc4random_uniform(UInt32(rangeY))) + minY
        bossBullet.position = CGPoint(x: size.width + bossBullet.size.width/2, y: randomY)
        
        bossBullet.physicsBody = SKPhysicsBody(rectangleOf: bossBullet.size)
//        bossBullet.physicsBody = SKPhysicsBody(texture: bossBullet.texture!, size: bossBullet.size)
        bossBullet.physicsBody!.affectedByGravity = false
        bossBullet.physicsBody!.isDynamic = true
        bossBullet.physicsBody!.categoryBitMask = bossProjectileCategory
        bossBullet.physicsBody!.contactTestBitMask = characterCategory
        bossBullet.physicsBody!.collisionBitMask = 0
                
        // Add the asset to the scene
        addChild(bossBullet)
        
        
        // Set up SKAction to move the asset to the left edge of the scene
        let moveDuration = TimeInterval(4.0) // set duration of the movement
        let moveAction = SKAction.moveTo(x: -bossBullet.size.width/2, duration: moveDuration)
        
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
        let assetXPosition = characterPosition.x + character.size.width/2 + characterBullet.size.width/2
        let assetYPosition = characterPosition.y
        characterBullet.position = CGPoint(x: assetXPosition, y: assetYPosition)
        
        characterBullet.physicsBody = SKPhysicsBody(rectangleOf: characterBullet.size)
//        characterBullet.physicsBody = SKPhysicsBody(texture: characterBullet.texture!, size: characterBullet.size)
        characterBullet.physicsBody!.affectedByGravity = false
        characterBullet.physicsBody!.isDynamic = true
        characterBullet.physicsBody!.categoryBitMask = characterProjectileCategory
        characterBullet.physicsBody!.contactTestBitMask = bossCategory
        characterBullet.physicsBody!.collisionBitMask = 0

        // Add the asset node to the scene
        addChild(characterBullet)

        // Calculate the duration of the asset's movement across the screen based on the speed constant
        let moveDuration = TimeInterval(2.0)

        // Create the action to move the asset across the screen, and remove it from the scene when it reaches the left edge
        let moveAction = SKAction.moveTo(x: size.width + characterBullet.size.width/2, duration: moveDuration)
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
        bg2.position = CGPoint(x: bg1.position.x + bg1.size.width, y: frame.midY)
        
        // Add the background nodes to the scene
        addChild(bg1)
        addChild(bg2)
        
        // Create the scrolling actions
        let moveLeft = SKAction.moveBy(x: -bg1.size.width, y: 0, duration: 10)
        let reset = SKAction.moveBy(x: bg1.size.width, y: 0, duration: 0)
        let sequence = SKAction.sequence([moveLeft, reset])
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
            
        if frameSinceBossBulletLastSpawn >= spawnInterval {
            frameSinceBossBulletLastSpawn = 0
            spawnBossProjectile()
        } 
        
        if frameSinceCharacterBulletLastSpawn >= spawnInterval{
            frameSinceCharacterBulletLastSpawn = 0
            spawnCharacterProjectile()
        }
    }

}

struct TheLastTrial: View {
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                SpriteView(scene: TheLastTrialScene(size: CGSize(width: geometry.size.width, height: geometry.size.height)), options: [.allowsTransparency])
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct TheLastTrial_Previews: PreviewProvider {
    static var previews: some View {
        TheLastTrial()
    }
}
