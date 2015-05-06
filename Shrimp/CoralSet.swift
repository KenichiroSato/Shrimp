//
//  CoralSet.swift
//  Shrimp
//
//  Created by 佐藤健一朗 on 2015/05/01.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation
import SpriteKit

public class CoralSet {
    
    //gap between above coral and under coral
    static private let CORAL_GAP : CGFloat = 160.0
    
    static let UNDER_TEXTURE = SKTexture(imageNamed: "coral_under")
    static let ABOVE_TEXTURE = SKTexture(imageNamed: "coral_above")
    
    let coralAbove : SKSpriteNode
    let coralUnder : SKSpriteNode
    let scoreDetector : SKNode
    
    init(frame:CGRect) {
        let underTexture = CoralSet.UNDER_TEXTURE
        underTexture.filteringMode = .Linear
        self.coralUnder = SKSpriteNode(texture: underTexture)
        coralUnder.position = CGPoint(x: 0.0, y: 0)
        coralUnder.physicsBody = SKPhysicsBody(texture: underTexture, size: underTexture.size())
        coralUnder.physicsBody?.dynamic = false
        coralUnder.physicsBody?.categoryBitMask = ColliderType.Coral
        coralUnder.physicsBody?.contactTestBitMask = ColliderType.Player

        let aboveTexture = CoralSet.ABOVE_TEXTURE
        aboveTexture.filteringMode = .Linear
        self.coralAbove = SKSpriteNode(texture: aboveTexture)
        coralAbove.position = CGPoint(x: 0.0,
            y:coralUnder.size.height / 2 + CoralSet.CORAL_GAP + coralAbove.size.height / 2)
        coralAbove.physicsBody = SKPhysicsBody(texture: aboveTexture, size: aboveTexture.size())
        coralAbove.physicsBody?.dynamic = false
        coralAbove.physicsBody?.categoryBitMask = ColliderType.Coral
        coralAbove.physicsBody?.contactTestBitMask = ColliderType.Player

        //Node for Score count up
        self.scoreDetector = SKNode()
        scoreDetector.position = CGPoint(x: (coralAbove.size.width / 2.0) + 5.0,
            y: frame.height / 2.0)
        scoreDetector.physicsBody = SKPhysicsBody(rectangleOfSize:
            CGSize(width: 10.0, height: frame.size.height))
        scoreDetector.physicsBody?.dynamic = false
        scoreDetector.physicsBody?.categoryBitMask = ColliderType.Score
        scoreDetector.physicsBody?.contactTestBitMask = ColliderType.Player
    }
    
    static func coralWidth() -> CGFloat {
        return CoralSet.UNDER_TEXTURE.size().width
    }
    
    func getSetNode() -> SKNode {
        let node = SKNode()
        node.addChild(coralUnder)
        node.addChild(coralAbove)
        node.addChild(scoreDetector)
        return node
    }
}