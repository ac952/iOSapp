//
//  Player.swift
//  FirstAppGame
//
//  Created by Aileen Cai on 8/14/17.
//  Copyright © 2017 aileen. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let Player: UInt32 = 1;
    static let Ground: UInt32 = 2;
    static let Obstacle: UInt32 = 3;
    
    static let Carrot: UInt32 = 4;
    static let Lettuce: UInt32 = 5;
    static let Beet: UInt32 = 6;
    
}

class Player: SKSpriteNode {
    
    func initialize() {
        
        self.name = "Player";
        self.zPosition = 3;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        self.setScale(2.65);
        
//        add physicsbody
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size);
        self.physicsBody?.affectedByGravity = true;
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.categoryBitMask = ColliderType.Player;
        self.physicsBody?.collisionBitMask = ColliderType.Ground | ColliderType.Obstacle | ColliderType.Lettuce | ColliderType.Beet | ColliderType.Carrot;
        
//        if player is on ground, can jump. if hit obstacle, end game or allow player to jump off
        self.physicsBody?.contactTestBitMask = ColliderType.Ground | ColliderType.Obstacle | ColliderType.Lettuce | ColliderType.Beet | ColliderType.Carrot;
        
        
    }
    
    func jump() {
//        normalize velocity
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0);
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 310));
        
    }
    
}
