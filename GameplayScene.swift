//
//  GameplayScene.swift
//  FirstAppGame
//
//  Created by Aileen Cai on 8/12/17.
//  Copyright © 2017 aileen. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackground();
    }
    
    func initialize() {
        createBackground();
        createGround();
        createClouds();
        
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

}





















