//
//  GameScene.swift
//  Shrimp
//
//  Created by 佐藤健一朗 on 2015/04/19.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    static private let SPEED : (STOP:CGFloat, START:CGFloat) = (0.0, 1.0)
    
    var baseNode:SKNode!
    var shrimp:Shrimp!
    var scoreLabel:ScoreLabel!
    var coral:Coral!
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        self.physicsWorld.contactDelegate = self
        
        initNodes()
        startGame()
    }
    
    private func initNodes() {
        baseNode = SKNode()
        self.addChild(baseNode)
        self.setupBackground()
        self.setupShrimp()
        self.setupCoral()
        self.setupScoreLabel()
    }
    
    private func startGame() {
        baseNode.speed = GameScene.SPEED.START
    }
    
    private func restartGame() {
        resetNodes()
        startGame()
    }
    
    private func resetNodes() {
        shrimp.reset()
        scoreLabel.reset()
        coral.reset()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        println("Contact!")
        if (isGameOver()) {
            return
        }
        
        if (self.isSroreType(contact.bodyA) || self.isSroreType(contact.bodyB)) {
            scoreLabel.countUp()
            
            if (self.isSroreType(contact.bodyA)) {
                contact.bodyA.categoryBitMask = ColliderType.None
                contact.bodyA.contactTestBitMask = ColliderType.None
            } else {
                contact.bodyB.categoryBitMask = ColliderType.None
                contact.bodyB.contactTestBitMask = ColliderType.None
            }
        } else if (self.isNoneType(contact.bodyA) || self.isNoneType(contact.bodyB)){
            // nop
        } else {
            gameOver()
        }
    }
    
    private func isGameOver() -> Bool {
        return baseNode.speed == GameScene.SPEED.STOP
    }
    
    private func gameOver() {
        baseNode.speed = GameScene.SPEED.STOP
        shrimp.roll()
    }
    
    private func isSroreType(body: SKPhysicsBody) -> Bool {
        return (body.categoryBitMask & ColliderType.Score == ColliderType.Score)
    }
    
    private func isNoneType(body: SKPhysicsBody) -> Bool {
        return (body.categoryBitMask & ColliderType.None == ColliderType.None)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if (isGameOver()) {
            restartGame()
            return
        }
        for touch : AnyObject in touches {
            shrimp.jump()
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func setupScoreLabel() {
        scoreLabel = ScoreLabel(frame: self.frame)
        self.addChild(scoreLabel.scoreLabelNode)
    }
    
    func setupShrimp() {
        shrimp = Shrimp(frame: self.frame)
        self.addChild(shrimp)
    }
    
    func setupCoral() {
        coral = Coral(parentFrame: self.frame, parentNode: self.baseNode)
        self.runAction(coral.getRepeatForeverAnim())
    }
    
    func setupBackground() {
        let background = Background(image: "background",
            y: Background.YPosition.Center,
            depth: Background.Depth.Infinite,
            cType: ColliderType.None)
        self.baseNode.addChild(background.repeatForeverNode(self.frame))

        let underRock = Background(image: "rock_under",
            y: Background.YPosition.Bottom,
            depth: Background.Depth.Far,
            cType: ColliderType.None)
        self.baseNode.addChild(underRock.repeatForeverNode(self.frame))
        
        let aboveRock = Background(image: "rock_above",
            y: Background.YPosition.Above,
            depth: Background.Depth.Far,
            cType: ColliderType.None)
        self.baseNode.addChild(aboveRock.repeatForeverNode(self.frame))
        
        let ceiling = Background(image: "ceiling",
            y: Background.YPosition.Above,
            depth: Background.Depth.Near,
            cType: ColliderType.World)
        self.baseNode.addChild(ceiling.repeatForeverNode(self.frame))
        
        let land = Background(image: "land",
            y: Background.YPosition.Bottom,
            depth: Background.Depth.Near,
            cType: ColliderType.World)
        self.baseNode.addChild(land.repeatForeverNode(self.frame))
    }
    
}
