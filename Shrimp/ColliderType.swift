//
//  ColliderType.swift
//  Shrimp
//
//  Created by 佐藤健一朗 on 2015/04/25.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation

struct ColliderType {
    static let Player: UInt32 = (1 << 0)
    static let World:  UInt32 = (1 << 1)
    static let Coral:  UInt32 = (1 << 2)
    static let Score:  UInt32 = (1 << 3)
    static let None:   UInt32 = (1 << 4)
}