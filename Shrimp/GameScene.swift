//
//  GameScene.swift
//  Shrimp
//
//  Created by 佐藤健一朗 on 2015/04/19.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    struct ColliderType {
        static let Player: UInt32 = (1 << 0)
        static let World:  UInt32 = (1 << 1)
        static let Coral:  UInt32 = (1 << 2)
        static let Score:  UInt32 = (1 << 3)
        static let None:   UInt32 = (1 << 4)
    }
    
    var baseNode:SKNode!
    var coralNode:SKNode!
    
    override func didMoveToView(view: SKView) {
        baseNode = SKNode()
        baseNode.speed = 1.0
        self.addChild(baseNode)
        
        coralNode = SKNode()
        baseNode.addChild(coralNode)
        
        self.setupBackground()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func setupBackground() {
        let texture = SKTexture(imageNamed: "background")
        self.repeatForeverBackgroundTexture(texture,
            duration:NSTimeInterval(texture.size().width / 10.0),
            yPosition:self.frame.size.height / 2,
            zPosition:-100.0,
            colliderType: ColliderType.None)
        
        let underRock = SKTexture(imageNamed: "rock_under")
        self.repeatForeverBackgroundTexture(underRock,
            duration:NSTimeInterval(underRock.size().width / 20.0),
            yPosition:underRock.size().height / 2,
            zPosition:-50.0,
            colliderType: ColliderType.None)
        
        let aboveRock = SKTexture(imageNamed: "rock_above")
        self.repeatForeverBackgroundTexture(aboveRock,
            duration: NSTimeInterval(underRock.size().width / 20.0),
            yPosition: self.frame.size.height - aboveRock.size().height / 2,
            zPosition: -50.0,
            colliderType: ColliderType.None)
        
        let ceiling = SKTexture(imageNamed: "ceiling")
        self.repeatForeverBackgroundTexture(ceiling,
            duration: NSTimeInterval(ceiling.size().width / 100.0),
            yPosition:self.frame.size.height - ceiling.size().height / 2,
            zPosition: 0.0,
            colliderType: ColliderType.World)

        let land = SKTexture(imageNamed: "land")
        self.repeatForeverBackgroundTexture(land,
            duration: NSTimeInterval(land.size().width / 100.0),
            yPosition:land.size().height / 2,
            zPosition: 0.0,
            colliderType: ColliderType.World)
    }
    
    func repeatForeverBackgroundTexture(texture:SKTexture,
        duration: NSTimeInterval,
        yPosition:CGFloat,
        zPosition:CGFloat,
        colliderType:UInt32) {
        texture.filteringMode = .Nearest
        let needNumber = 2.0 + (self.frame.size.width / texture.size().width)
        
        let repeatForeverAnim = self.repeatForeverAnim(texture, duration: duration)
        
        for var i:CGFloat = 0; i < needNumber; i++ {
            let sprite = SKSpriteNode(texture: texture)
            sprite.zPosition = zPosition
            sprite.position = CGPoint(x: i * sprite.size.width, y: yPosition)
            self.setPhysicsBody(sprite, type: colliderType)
            sprite.runAction(repeatForeverAnim)
            baseNode.addChild(sprite)
        }
    }
    
    func setPhysicsBody(node:SKSpriteNode, type:UInt32) {
        if let texture = node.texture {
            node.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
            node.physicsBody?.dynamic = false
            node.physicsBody?.categoryBitMask = type
        }
    }
    
    func repeatForeverAnim(texture:SKTexture, duration:NSTimeInterval) -> SKAction {
        let moveAnim = SKAction.moveByX(-texture.size().width,
            y: 0.0, duration: duration)
        let resetAnim = SKAction.moveByX(texture.size().width,
            y: 0.0, duration: 0.0)
         return SKAction.repeatActionForever(SKAction.sequence([moveAnim, resetAnim]))
    }
}
