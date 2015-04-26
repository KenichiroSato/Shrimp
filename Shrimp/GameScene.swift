//
//  GameScene.swift
//  Shrimp
//
//  Created by 佐藤健一朗 on 2015/04/19.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var baseNode:SKNode!
    var coralNode:SKNode!
    var shrimp:Shrimp!
    var scoreLabelNode:SKLabelNode!
    var score: UInt32!
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        
        baseNode = SKNode()
        baseNode.speed = 1.0
        self.addChild(baseNode)
        
        coralNode = SKNode()
        baseNode.addChild(coralNode)
        
        self.setupBackground()
        self.setupShrimp()
        self.setupCoral()
        self.setupScoreLabel()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch : AnyObject in touches {
            let location = touch.locationInNode(self)
            shrimp.jump()
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func setupScoreLabel() {
        score = 0

        scoreLabelNode = SKLabelNode(fontNamed: "Arial Bold")
        scoreLabelNode.fontColor = UIColor.blackColor()
        scoreLabelNode.position = CGPoint(x: self.frame.width / 2.0, y: self.frame.size.height * 0.9)
        scoreLabelNode.zPosition = 100.0
        scoreLabelNode.text = String(score)
        self.addChild(scoreLabelNode)
    }
    
    func setupShrimp() {
        shrimp = Shrimp(frame: self.frame)
        self.addChild(shrimp)
    }
    
    func setupCoral() {
        let coralUnder = SKTexture(imageNamed: "coral_under")
        coralUnder.filteringMode = .Linear
        let coralAbove = SKTexture(imageNamed: "coral_above")
        coralAbove.filteringMode = .Linear
        
        let distanceToMove = CGFloat(self.frame.size.width + 2.0 * coralUnder.size().width)
        
        let moveAnim = SKAction.moveByX(-distanceToMove, y: 0.0, duration: NSTimeInterval(distanceToMove / 100.0))
        let removeAnim = SKAction.removeFromParent()
        let coralAnim = SKAction.sequence([moveAnim, removeAnim])
        
        let newCoralAnim = SKAction.runBlock({
            
            let coral = SKNode()
            coral.position = CGPoint(x: self.frame.size.width + coralUnder.size().width * 2,
                y: 0.0)
            coral.zPosition = -50.0
            
            let height = UInt32(self.frame.size.height / 4)
            let y = CGFloat(arc4random_uniform(height))
            
            let under = SKSpriteNode(texture: coralUnder)
            under.position = CGPoint(x: 0.0, y: y)
            under.physicsBody = SKPhysicsBody(texture: coralUnder, size: under.size)
            under.physicsBody?.dynamic = false
            under.physicsBody?.categoryBitMask = ColliderType.Coral
            under.physicsBody?.contactTestBitMask = ColliderType.Player
            coral.addChild(under)
            
            let above = SKSpriteNode(texture: coralAbove)
            above.position = CGPoint(x: 0.0,
                y: y + under.size.height / 2 + 160.0 + above.size.height / 2)
            above.physicsBody = SKPhysicsBody(texture: coralAbove, size: above.size)
            above.physicsBody?.dynamic = false
            above.physicsBody?.categoryBitMask = ColliderType.Coral
            above.physicsBody?.contactTestBitMask = ColliderType.Player
            coral.addChild(above)
            
            //Node for Score count up
            let scoreNode = SKNode()
            scoreNode.position = CGPoint(x: (above.size.width / 2.0) + 5.0,
                y: self.frame.height / 2.0)
            scoreNode.physicsBody = SKPhysicsBody(rectangleOfSize:
                CGSize(width: 10.0, height: self.frame.size.height))
            scoreNode.physicsBody?.dynamic = false
            scoreNode.physicsBody?.categoryBitMask = ColliderType.Score
            scoreNode.physicsBody?.contactTestBitMask = ColliderType.Player
            coral.addChild(scoreNode)
            
            coral.runAction(coralAnim)
            self.coralNode.addChild(coral)
        
        })
        let delayAnim = SKAction.waitForDuration(2.5)
        let repeatForeverAnim = SKAction.repeatActionForever(SKAction.sequence([newCoralAnim, delayAnim]))
        
        self.runAction(repeatForeverAnim)
        
    }
    
    func setupBackground() {
        let background = Background(image: "background",
            y: Background.YPosition.Center,
            depth: Background.Depth.Infinite,
            cType: ColliderType.None)
        self.baseNode.addChild(background.repeatForeverNode(self.frame))

        let underRock = Background(image: "rock_under",
            y: Background.YPosition.Bottom,
            depth: Background.Depth.Far,
            cType: ColliderType.None)
        self.baseNode.addChild(underRock.repeatForeverNode(self.frame))
        
        let aboveRock = Background(image: "rock_above",
            y: Background.YPosition.Above,
            depth: Background.Depth.Far,
            cType: ColliderType.None)
        self.baseNode.addChild(aboveRock.repeatForeverNode(self.frame))
        
        let ceiling = Background(image: "ceiling",
            y: Background.YPosition.Above,
            depth: Background.Depth.Near,
            cType: ColliderType.World)
        self.baseNode.addChild(ceiling.repeatForeverNode(self.frame))
        
        let land = Background(image: "land",
            y: Background.YPosition.Bottom,
            depth: Background.Depth.Near,
            cType: ColliderType.World)
        self.baseNode.addChild(land.repeatForeverNode(self.frame))
    }
    
}
