//
//  GameplayScene.swift
//  FirstAppGame
//
//  Created by Aileen Cai on 8/12/17.
//  Copyright © 2017 aileen. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
//    refering to class Player in player.swift
    var player = Player();
    
//    limit number of jumps
    var canJump = false;
    
    var obstacles = [SKSpriteNode]();
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackground();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        player.jump();
        
//        allow player to jump off of carrot
        if canJump == true {
            canJump = false;
            player.jump();
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
//        set firstbody to be the player always
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
            
//            if bodyA is ground or obstacle
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
            
        }
        
//        if player lands on ground, it can jump
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Ground" {
            canJump = true;
        }
        
//        if player lands onto obstacle, it will die
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Obstacle" {
            canJump = false;
        }
        
//        if player lands on carrot, it can jump again
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Carrot" {
            canJump = true;
        }
        
        
    }
    
    func initialize() {
        
        physicsWorld.contactDelegate = self;
        
        createBackground();
        createGround();
        createClouds();
        createPlayer();
        createObstacle();
        
//        call obstacles infinitely (repeat)
//        spawn obstacle every two seconds
        Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.spawnObstacle), userInfo: nil, repeats: true);
        
    }
    
    func createBackground() {
        
        for i in 0...2 {
            let bg = SKSpriteNode(imageNamed: "sky");
            bg.name = "BG";
            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            bg.size = CGSize(width: 1334, height: 750);
            bg.position = CGPoint(x: CGFloat(i) * bg.size.width, y: 0);
            bg.zPosition = 0;
            self.addChild(bg);
            
        }
   
    }
    
    func createGround() {
        
        for i in 0...2 {
            let ground = SKSpriteNode(imageNamed: "ground-1");
            ground.name = "Ground";
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            ground.size = CGSize(width: 1334, height: 320);
            ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: -380);
            ground.zPosition = 1;
            
//            add physicsBody to ground so player does not fall off screen
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size);
            ground.physicsBody?.affectedByGravity = false;
            ground.physicsBody?.isDynamic = false;
            ground.physicsBody?.contactTestBitMask = ColliderType.Ground;
            
            self.addChild(ground);
        }
        
    }
    
    func createClouds() {
        
        for i in 0...2 {
            let cloud = SKSpriteNode(imageNamed: "clouds-1");
            cloud.name = "Cloud";
            cloud.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            cloud.setScale(1.3);
            cloud.size = CGSize(width: 1334, height: 350);
            cloud.position = CGPoint(x: CGFloat(i) * cloud.size.width, y: 250);
            cloud.zPosition = 1;
            self.addChild(cloud);
        }
        
    }
    
    func moveBackground() {
        
        enumerateChildNodes(withName: "BG", using: ({
            (node, error) in
            
            node.position.x += 4.5;
            
            if node.position.x > (self.frame.width) {
                node.position.x -= self.frame.width * 3;
            }
        
        }));
        
        enumerateChildNodes(withName: "Ground", using: ({
            (node, error) in
            
            node.position.x -= 4.0;
            
            if node.position.x < -(self.frame.width) {
                node.position.x += self.frame.width * 3
            }
            
        }));
        
    }
    
    func createPlayer() {
        player = Player(imageNamed: "bunny1");
        player.position = CGPoint(x: -200, y: 0)
        player.initialize();
        self.addChild(player);
        
    }
    
//    change renctangle of size of donuts, make it smaller
//    vary size of obstacle, and allow bunny to jump infinitely. or only twice
    func createObstacle() {
        
        for i in 0...3 {
            let obstacle = SKSpriteNode(imageNamed: "obstacle\(i)");
            
            if i == 0 {
                obstacle.name = "Carrot";
                obstacle.setScale(0.8);
                obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: -300);
                obstacle.size = CGSize(width: 200, height: 550);
                obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size );
                
                
//                can jump on this obstacle
            } else {
                obstacle.name = "Obstacle";
                obstacle.setScale(0.85);
//                these obstacles cause player to die
                obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: -150);
                obstacle.physicsBody = SKPhysicsBody(circleOfRadius: obstacle.size.width / 2 );
                
            }
            
            obstacle.zPosition = 2;
            obstacle.anchorPoint = CGPoint (x: 0.5, y: 0.5);
    
//            set obstacle on ground level
//            obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size );
            obstacle.physicsBody?.affectedByGravity = false;
            obstacle.physicsBody?.isDynamic = false;
            obstacle.physicsBody?.allowsRotation = false;
            obstacle.physicsBody?.categoryBitMask = ColliderType.Obstacle;
            obstacle.physicsBody?.collisionBitMask = ColliderType.Ground | ColliderType.Player;
            obstacle.physicsBody?.contactTestBitMask = ColliderType.Player | ColliderType.Ground;
            
            obstacles.append(obstacle);
         
        }

    }
    
    func spawnObstacle() {
        
        let index = Int(arc4random_uniform(UInt32(obstacles.count)));
        
//        obstacles.count = 4 (0-3)
        
//        copy obstacle if it calls the same index value again
        let obstacle = obstacles[index].copy() as! SKSpriteNode;
        
        
//        move obstcle toward player
        let move = SKAction.moveTo(x: -(self.frame.size.width * 2), duration: TimeInterval(15));
        
        let remove = SKAction.removeFromParent();
        
        let actionSequence = SKAction.sequence([move,remove]);
        obstacle.run(actionSequence);
        
        self.addChild(obstacle);
    }
    
}




















