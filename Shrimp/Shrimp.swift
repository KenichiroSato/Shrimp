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
    
    static private let BASE_TEXTURE = SKTexture(imageNamed: "shrimp01")

    let parentFrame : CGRect
    
    init(frame:CGRect) {
        parentFrame = frame
        super.init(texture: Shrimp.BASE_TEXTURE, color: UIColor.whiteColor(), size: Shrimp.BASE_TEXTURE.size())

        initPosition()
        initAnimation()
        initPhysicsBody()
    }
    
    private func initPosition() {
        self.position = CGPoint(x: parentFrame.size.width * 0.35, y: parentFrame.size.height * 0.6)
        self.zRotation = 0.0
    }
    
    private func initAnimation() {
        var playerTexture = [SKTexture]()
        for imageName in Constants.PlayerImages {
            let texture = SKTexture(imageNamed: imageName)
            texture.filteringMode = .Linear
            playerTexture.append(texture)
        }
        
        let playerAnimation = SKAction.animateWithTextures(playerTexture,
            timePerFrame: 0.2)
        let loopAnimation = SKAction.repeatActionForever(playerAnimation)
        self.runAction(loopAnimation)
        
    }
    
    private func initPhysicsBody() {
        self.physicsBody = SKPhysicsBody(texture: Shrimp.BASE_TEXTURE, size: Shrimp.BASE_TEXTURE.size())
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
            self.removeAllActions()
        })
    }
    
    func reset() {
        self.removeAllActions()
        self.physicsBody?.velocity = CGVector.zeroVector

        initPosition()
        initAnimation()
    }
}