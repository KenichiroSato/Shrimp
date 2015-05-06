//
//  ScoreLabel.swift
//  Shrimp
//
//  Created by 佐藤健一朗 on 2015/05/01.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation
import SpriteKit

public class ScoreLabel {
    
    private var score:UInt32
    private(set) var scoreLabelNode:SKLabelNode
    
    init(frame:CGRect) {
        score = 0
        scoreLabelNode = SKLabelNode(fontNamed: "Arial Bold")
        scoreLabelNode.fontColor = UIColor.blackColor()
        scoreLabelNode.position = CGPoint(x: frame.width / 2.0, y: frame.size.height * 0.9)
        scoreLabelNode.zPosition = 100.0
        scoreLabelNode.text = String(score)
    }

    func countUp() {
        score++
        scoreLabelNode.text = String(score)
        
        let scaleUpAnim = SKAction.scaleTo(1.5, duration: 0.1)
        let scaleDownAnim = SKAction.scaleTo(1.0, duration: 0.1)
        scoreLabelNode.runAction(SKAction.sequence([scaleUpAnim, scaleDownAnim]))
    }
    
    func reset() {
        score = 0
        scoreLabelNode.text = String(score)
    }
}