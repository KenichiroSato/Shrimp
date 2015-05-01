//
//  Background.swift
//  Shrimp
//
//  Created by 佐藤健一朗 on 2015/04/25.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation
import SpriteKit

public class Background {
    
    enum YPosition {
        case Above, Center, Bottom
    }
    
    enum Depth {
        case Infinite, Far, Near
        
        func zPosition() -> CGFloat {
            switch self {
            case .Infinite: return -100.0
            case .Far:      return -50.0
            case .Near:     return 0.0
            }
        }
        
        func speed() -> CGFloat {
            switch self {
            case .Infinite: return 10.0
            case .Far:      return 20.0
            case .Near:     return 100.0
            }            
        }
    }
    
    let texture: SKTexture
    let y: YPosition
    let depth: Depth
    let colliderType: UInt32
    
    init(image:String, y: YPosition, depth: Depth, cType: UInt32) {
        self.texture = SKTexture(imageNamed: image)
        self.texture.filteringMode = .Nearest
        self.y = y
        self.depth = depth
        self.colliderType = cType
    }
    
    public func repeatForeverNode(frame: CGRect) -> SKNode {
        let baseNode = SKNode()
        let needNumber = 2.0 + (frame.size.width / self.texture.size().width)
            
        let repeatForeverAnim = self.repeatForeverAnim()
            
        for var i:CGFloat = 0; i < needNumber; i++ {
            let sprite = SKSpriteNode(texture: self.texture)
            sprite.zPosition = self.depth.zPosition()
            sprite.position = CGPoint(x: i * sprite.size.width, y: self.yPosition(frame))
            self.setPhysicsBody(sprite)
            sprite.runAction(repeatForeverAnim)
            baseNode.addChild(sprite)
        }
        return baseNode
    }
    
    private func setPhysicsBody(node:SKSpriteNode) {
        if let texture = node.texture {
            node.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
            node.physicsBody?.dynamic = false
            node.physicsBody?.categoryBitMask = self.colliderType
        }
    }

    private func repeatForeverAnim() -> SKAction {
        let moveAnim = SKAction.moveByX(-self.texture.size().width,
            y: 0.0, duration: self.duration())
        let resetAnim = SKAction.moveByX(self.texture.size().width,
            y: 0.0, duration: 0.0)
        return SKAction.repeatActionForever(SKAction.sequence([moveAnim, resetAnim]))
    }

    private func duration() -> NSTimeInterval {
        return NSTimeInterval(self.texture.size().width / self.depth.speed())
    }
    
    private func yPosition(frame: CGRect) -> CGFloat {
        switch self.y {
        case .Above: return frame.size.height - self.texture.size().height / 2
        case .Center: return frame.size.height / 2
        case .Bottom: return self.texture.size().height / 2
        }
    }
}