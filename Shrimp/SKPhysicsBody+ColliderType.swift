//
//  SKPhysicsContact+ColliderType.swift
//  Shrimp
//
//  Created by 佐藤健一朗 on 2015/04/27.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation
import SpriteKit

extension SKPhysicsBody {
    
    func isScoreType() -> Bool {
        return ((self.categoryBitMask & ColliderType.Score == ColliderType.Score))
    }
    
    func isNoneType() -> Bool {
        return ((self.categoryBitMask & ColliderType.None == ColliderType.None))
    }
    
    func setColliderType(type: UInt32) {
        self.categoryBitMask = type
        self.contactTestBitMask = type
    }
}

extension String {
    func aho() -> String {
        return "aho"
    }
}