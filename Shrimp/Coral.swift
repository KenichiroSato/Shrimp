//
//  Coral.swift
//  Shrimp
//
//  Created by 佐藤健一朗 on 2015/04/26.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation
import SpriteKit

public class Coral {
    
    let parentFrame: CGRect
    let parentNode: SKNode
    
    init (parentFrame: CGRect, parentNode: SKNode) {
        self.parentFrame = parentFrame
        self.parentNode = parentNode
    }
    
    public func getRepeatForeverAnim() -> SKAction {
    
        let coralUnder = SKTexture(imageNamed: "coral_under")
        coralUnder.filteringMode = .Linear
        let coralAbove = SKTexture(imageNamed: "coral_above")
        coralAbove.filteringMode = .Linear
        
        let distanceToMove = CGFloat(self.parentFrame.size.width + 2.0 * coralUnder.size().width)
        
        let moveAnim = SKAction.moveByX(-distanceToMove, y: 0.0, duration: NSTimeInterval(distanceToMove / 100.0))
        let removeAnim = SKAction.removeFromParent()
        let coralAnim = SKAction.sequence([moveAnim, removeAnim])
        
        let newCoralAnim = SKAction.runBlock({
            
            let coral = SKNode()
            coral.position = CGPoint(x: self.parentFrame.size.width + coralUnder.size().width * 2,
                y: 0.0)
            coral.zPosition = -50.0
            
            let height = UInt32(self.parentFrame.size.height / 4)
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
                y: self.parentFrame.height / 2.0)
            scoreNode.physicsBody = SKPhysicsBody(rectangleOfSize:
                CGSize(width: 10.0, height: self.parentFrame.size.height))
            scoreNode.physicsBody?.dynamic = false
            scoreNode.physicsBody?.categoryBitMask = ColliderType.Score
            scoreNode.physicsBody?.contactTestBitMask = ColliderType.Player
            coral.addChild(scoreNode)
            
            coral.runAction(coralAnim)
            self.parentNode.addChild(coral)
            
        })
        let delayAnim = SKAction.waitForDuration(2.5)
        let repeatForeverAnim = SKAction.repeatActionForever(SKAction.sequence([newCoralAnim, delayAnim]))
        
        return repeatForeverAnim
    }
    
}
