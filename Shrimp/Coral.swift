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
    let baseNode: SKNode
    
    init (parentFrame: CGRect, parentNode: SKNode) {
        self.parentFrame = parentFrame
        self.baseNode = SKNode()
        parentNode.addChild(baseNode)
    }
    
    public func getRepeatForeverAnim() -> SKAction {
    
        let moveAnim = SKAction.moveByX(-distanceToMove(), y: 0.0,
            duration: NSTimeInterval(distanceToMove() / 100.0))
        let removeAnim = SKAction.removeFromParent()
        let coralAnim = SKAction.sequence([moveAnim, removeAnim])
        
        let newCoralAnim = SKAction.runBlock({
            
            let coralSet = CoralSet(frame: self.parentFrame)
            
            let coralSetNode = coralSet.getSetNode()
            coralSetNode.position = CGPoint(x: self.distanceToMove(), y: self.randomY())
            coralSetNode.zPosition = -50.0
            coralSetNode.runAction(coralAnim)
            self.baseNode.addChild(coralSetNode)
        })
        let delayAnim = SKAction.waitForDuration(2.5)
        let repeatForeverAnim = SKAction.repeatActionForever(SKAction.sequence([newCoralAnim, delayAnim]))
        
        return repeatForeverAnim
    }
    
    private func randomY() -> CGFloat {
        let baseHeight = UInt32(self.parentFrame.size.height / 4)
        return CGFloat(arc4random_uniform(baseHeight))
    }
    
    private func distanceToMove() -> CGFloat {
        return CGFloat(self.parentFrame.size.width + 2.0 * CoralSet.coralWidth())
    }
    
    func reset() {
        self.baseNode.removeAllChildren()
    }
    
}
