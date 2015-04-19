//
//  GameScene.swift
//  Shrimp
//
//  Created by 佐藤健一朗 on 2015/04/19.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var baseNode:SKNode!
    var coralNode:SKNode!
    
    override func didMoveToView(view: SKView) {
        baseNode = SKNode()
        baseNode.speed = 1.0
        self.addChild(baseNode)
        
        coralNode = SKNode()
        baseNode.addChild(coralNode)
        
        self.setupBackgroundSea()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func setupBackgroundSea() {
        
        let texture = SKTexture(imageNamed: "background")
        texture.filteringMode = .Nearest
        let needNumber = 2.0 + (self.frame.size.width / texture.size().width)
        
        let moveAnim = SKAction.moveByX(-texture.size().width,
            y: 0.0, duration: NSTimeInterval(texture.size().width / 10.0))
        let resetAnim = SKAction.moveByX(texture.size().width,
            y: 0.0, duration: 0.0)
        let repeatForeverAnim = SKAction.repeatActionForever(SKAction.sequence([moveAnim, resetAnim]))
        
        for var i:CGFloat = 0; i < needNumber; i++ {
            let sprite = SKSpriteNode(texture: texture)
            sprite.zPosition = -100.0
            sprite.position = CGPoint(x: i * sprite.size.width, y: self.frame.size.height / 2)
            sprite.runAction(repeatForeverAnim)
            baseNode.addChild(sprite)
        }
    }
}
