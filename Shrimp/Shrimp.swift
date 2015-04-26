//
//  Shrimp.swift
//  Shrimp
//
//  Created by 佐藤健一朗 on 2015/04/25.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation
import SpriteKit

public class Shrimp : SKSpriteNode{
    
    struct Constants {
        static let PlayerImages = ["shrimp01","shrimp02","shrimp03","shrimp04",]
    }

    init(frame:CGRect) {
        var playerTexture = [SKTexture]()
        for imageName in Constants.PlayerImages {
            let texture = SKTexture(imageNamed: imageName)
            texture.filteringMode = .Linear
            playerTexture.append(texture)
        }
        let baseTexture: SKTexture = playerTexture[0]
        super.init(texture: baseTexture, color: UIColor.whiteColor(), size: baseTexture.size())
        
        let playerAnimation = SKAction.animateWithTextures(playerTexture,
            timePerFrame: 0.2)
        let loopAnimation = SKAction.repeatActionForever(playerAnimation)
        
        self.position = CGPoint(x: frame.size.width * 0.35, y: frame.size.height * 0.6)
        self.runAction(loopAnimation)
        
        self.physicsBody = SKPhysicsBody(texture: baseTexture, size: baseTexture.size())
        self.physicsBody?.dynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.World | ColliderType.Coral
        self.physicsBody?.contactTestBitMask = ColliderType.World | ColliderType.Coral
    }
    
    public required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func jump() {
        //set power to 0 which is given to player
        self.physicsBody?.velocity = CGVector.zeroVector
        //add y power to player
        self.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 23.0))
    }
    
    public func roll() {
        let rolling = SKAction.rotateByAngle(CGFloat(M_PI) * self.position.y * 0.01, duration: 1.0)
        self.runAction(rolling, completion: {
            self.speed = 0.0
        })

    }
}