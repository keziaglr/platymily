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
    
    let playerTexture = SKTexture(imageNamed: "Holding_Basket")
    let hearthTexture = SKTexture(imageNamed: "Platy")
    var player: SKSpriteNode!
    var player2: SKSpriteNode!
    var ground: SKSpriteNode!
    var rock: SKSpriteNode!
    var bread: SKSpriteNode!
    var bread2: SKSpriteNode!
    var hearth1: SKSpriteNode!
    var hearth2: SKSpriteNode!
    var hearth3: SKSpriteNode!
    var hearth21: SKSpriteNode!
    var hearth22: SKSpriteNode!
    var hearth23: SKSpriteNode!
    var score = 0
    var score2 = 0
    var highscore = 0
    let scoreLabel = SKLabelNode(text: "0")
    let scoreLabel2 = SKLabelNode(text: "0")
    
    
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
        
        player2 = SKSpriteNode(texture: playerTexture, size: CGSize(width: 100, height: 100))
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
        
        hearth21 = SKSpriteNode(texture: hearthTexture, size: CGSize(width: 25, height: 25))
        hearth21.position = CGPoint(x: 20, y: frame.midY * 3 / 2 - 30)
        hearth21.zRotation = CGFloat.pi * 0.5
        hearth22 = SKSpriteNode(texture: hearthTexture, size: CGSize(width: 25, height: 25))
        hearth22.position = CGPoint(x: 20, y: frame.midY * 3 / 2)
        hearth22.zRotation = CGFloat.pi * 0.5
        hearth23 = SKSpriteNode(texture: hearthTexture, size: CGSize(width: 25, height: 25))
        hearth23.position = CGPoint(x: 20, y: frame.midY * 3 / 2 + 30)
        hearth23.zRotation = CGFloat.pi * 0.5
        addChild(hearth21)
        addChild(hearth22)
        addChild(hearth23)
    }
    
    func createRock(testing: Bool) {
        let rockTexture = SKTexture(imageNamed: "Bomb")
        rock = SKSpriteNode(texture: rockTexture)
        rock.size = CGSize(width: 25, height: 25)
        let randomY = testing ? CGFloat.random(in: rock.size.width...size.height/2 - rock.size.width) : CGFloat.random(in: size.height/2+rock.size.width...size.height - rock.size.width)
        rock.zRotation = CGFloat.pi/2
        rock.position = CGPoint(x: 0, y: randomY)
        rock.physicsBody = SKPhysicsBody(rectangleOf: rock.size)
        rock.physicsBody?.categoryBitMask = PhysicsCategory.rock
        rock.physicsBody?.contactTestBitMask = PhysicsCategory.player2 | PhysicsCategory.player
        rock.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
        rock.physicsBody?.linearDamping = 10

        addChild(rock)
    }
    
    func createBread(testing: Bool) {
        let breadTexture = SKTexture(imageNamed: "Gacha")
        bread = SKSpriteNode(texture: breadTexture)
        bread.name = "bread"
        bread.size = CGSize(width: 25, height: 25)
        let randomY = testing ? CGFloat.random(in: bread.size.width...size.height/2 - bread.size.width) : CGFloat.random(in: size.height/2+bread.size.width...size.height - bread.size.width)
        bread.position = CGPoint(x: 0, y: randomY)
        bread.zRotation = CGFloat.pi/2
        bread.physicsBody = SKPhysicsBody(rectangleOf: bread.size)
        bread.physicsBody?.categoryBitMask = PhysicsCategory.bread
        bread.physicsBody?.contactTestBitMask = PhysicsCategory.player | PhysicsCategory.player2
        bread.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
        bread.physicsBody?.linearDamping = 10

        addChild(bread)

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
            score += 1
            
            scoreLabel.text = "\(score)"
        }
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.player2 && contact.bodyB.categoryBitMask == PhysicsCategory.bread {
            contact.bodyB.node?.removeFromParent()
            score2 += 1
            
            scoreLabel2.text = "\(score2)"
        }
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.player && contact.bodyB.categoryBitMask == PhysicsCategory.rock {
            contact.bodyB.node?.removeFromParent()
            
            if hearth3.parent != nil {
                hearth3.removeFromParent()
            } else if hearth2.parent != nil {
                hearth2.removeFromParent()
            } else if hearth1.parent != nil {
                hearth1.removeFromParent()
            }
            scoreLabel.text = "\(score)"
        }
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.player2 && contact.bodyB.categoryBitMask == PhysicsCategory.rock {
            contact.bodyB.node?.removeFromParent()
            
            if hearth23.parent != nil {
                hearth23.removeFromParent()
            } else if hearth22.parent != nil {
                hearth22.removeFromParent()
            } else if hearth21.parent != nil {
                hearth21.removeFromParent()
            }
            scoreLabel2.text = "\(score)"
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if(location.y < self.size.height/2 - 50){
                player.position.y = location.y
            }
            
            if(location.y > self.size.height/2 + 50){
                player2.position.y = location.y
            }
        }
    }

}

struct CatchGacha: View {
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                SpriteView(scene: CatchGachaScene(size: CGSize(width: geometry.size.width, height: geometry.size.height)), options: [.allowsTransparency])
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}


struct CatchGacha_Previews: PreviewProvider {
    static var previews: some View {
        CatchGacha()
    }
}
