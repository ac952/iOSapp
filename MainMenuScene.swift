//
//  MainMenuScene.swift
//  FirstAppGame
//
//  Created by Aileen Cai on 8/21/17.
//  Copyright © 2017 aileen. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    var score=SKLabelNode();
    
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
            
            //open instructions
            if atPoint(location).name == "InstructionButton" {
                let inst = InstructionScene(fileNamed: "InstructionScene");
                
                // let everything be visible on scene within a second
                inst?.scaleMode = .aspectFit
                self.view?.presentScene(inst!, transition: SKTransition.doorway(withDuration: TimeInterval(1)));
            }
            
            if atPoint(location).name == "Highscore" {
                Highscore();
            }
            
        }
        
    }
    
    func initialize() {
        createTitle();
        createGround();
        createBackground();
        createButton();
        createClouds();
        
    }
    
//    ADD TEXT-TITLE OF GAME
    func createTitle() {
        
        let title = SKSpriteNode(imageNamed: "title");
        title.name = "Title";
        title.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        title.size = CGSize(width: 750, height: 180);
        title.position = CGPoint(x: 0, y: 280);
        title.zPosition = 5;
        self.addChild(title);
        
    }

    
    func createBackground() {
       
            let bg = SKSpriteNode(imageNamed: "sky");
            bg.name = "BG";
            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            bg.size = CGSize(width: 1334, height: 750);
            bg.zPosition = 1;
            self.addChild(bg);
        
    }
    
//    scroll ground
    
    func createGround() {
        
            let ground = SKSpriteNode(imageNamed: "ground-1");
            ground.name = "Ground";
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            ground.size = CGSize(width: 1334, height: 320);
            ground.position = CGPoint(x: 0, y: -380);
            ground.zPosition = 3;
            self.addChild(ground);
        
    }
    
    func createClouds() {
        
            let cloud = SKSpriteNode(imageNamed: "clouds-1");
            cloud.name = "Cloud";
            cloud.anchorPoint = CGPoint(x: 0.5, y: 0.5);
//            cloud.setScale(1.3);
            cloud.size = CGSize(width: 1334, height: 350);
            cloud.position = CGPoint(x: 0, y: 250);
            cloud.zPosition = 1;
            self.addChild(cloud);
        }
    
    func createButton() {
        let play = SKSpriteNode(imageNamed: "Play");
        play.name = "Play";
        play.zPosition = 5;
        play.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        play.setScale(0.90);
        play.position = CGPoint(x: 0, y: 30);
        
        
        let highScore = SKSpriteNode(imageNamed: "Highscore");
        highScore.name = "Highscore";
        highScore.zPosition = 5;
        highScore.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        highScore.position = CGPoint(x: 252, y: -147);
        highScore.setScale(1.05);
        
        let instructButton = SKSpriteNode(imageNamed: "instructions");
        instructButton.name = "InstructionButton"
        instructButton.zPosition = 5;
        instructButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        instructButton.position = CGPoint(x:-252, y: -102)
        instructButton.setScale(0.90)
        
        self.addChild(play);
        self.addChild(highScore);
        self.addChild(instructButton);
    }
    
    func Highscore(){
        score.removeFromParent();
        score = SKLabelNode(fontNamed: "04b_19");
        score.fontSize = 100;
        score.text = "\(UserDefaults.standard.integer(forKey: "highscore"))";
        score.position = CGPoint(x:0, y:-345);
        score.zPosition = 10;
        self.addChild(score);
    }
    
}





