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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
//            touch any location in screen
            let location = touch.location(in: self);
//            if touch the play node, load gameplay scene
            if atPoint(location).name == "Play" {
                let game = GameplayScene(fileNamed: "GameplayScene");
                
//                let everything be visible on scene within a second
                game?.scaleMode = .aspectFit
                self.view?.presentScene(game!, transition: SKTransition.doorway(withDuration: TimeInterval(1)));
            
            }
            
        }
        
    }
    
    func initialize() {
        createGround();
        createBackground();
        createButton();
    }
    
//    ADD TEXT-TITLE OF GAME
    
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
    
    func createButton() {
        let play = SKSpriteNode(imageNamed: "Play");
        play.name = "Play";
        play.zPosition = 5;
        play.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        play.setScale(0.7);
        play.position = CGPoint(x: -250, y: 0);
        
        
        let highScore = SKSpriteNode(imageNamed: "Highscore");
        highScore.name = "Highscore";
        highScore.zPosition = 5;
        highScore.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        highScore.position = CGPoint(x: 250, y: 0);
        highScore.setScale(0.7);
        
        self.addChild(play);
        self.addChild(highScore);
    }
    
    
}





