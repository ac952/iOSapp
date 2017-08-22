//
//  MainMenuScene.swift
//  FirstAppGame
//
//  Created by Aileen Cai on 8/21/17.
//  Copyright © 2017 aileen. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    func initialize() {
        createGround();
        createBackground();
        
    }
    
    func createBackground() {
       
            let bg = SKSpriteNode(imageNamed: "sky");
            bg.name = "BG";
            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            bg.size = CGSize(width: 1334, height: 750);
            bg.zPosition = 1;
            self.addChild(bg);
        
    }
    
    func createGround() {
        
            let ground = SKSpriteNode(imageNamed: "ground-1");
            ground.name = "Ground";
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            ground.size = CGSize(width: 1334, height: 320);
            ground.position = CGPoint(x: 0, y: -380);
            ground.zPosition = 3;
            self.addChild(ground);
        
    }
    
    
    
}





