//
//  InstructionScene.swift
//  FirstAppGame
//
//  Created by Aileen Cai on 9/7/17.
//  Copyright © 2017 aileen. All rights reserved.
//

import SpriteKit


class InstructionScene: SKScene {
    
    override func didMove(to view: SKView) {
        initialize();
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            // touch any location in screen
            let location = touch.location(in: self);
            // if touch the ok node, load mainmenu scene
            if atPoint(location).name == "Ok" {
                let main = MainMenuScene(fileNamed: "MainMenuScene");
                
            //let everything be visible on scene within a second
                main?.scaleMode = .aspectFit
                self.view?.presentScene(main!, transition: SKTransition.doorway(withDuration: TimeInterval(1)));
            }
            
        }

        
    }
    
    func initialize() {
        createInstructionBG()
        createOk()
    }
    
    func createInstructionBG() {
        let instruct = SKSpriteNode(imageNamed:"instruct")
        instruct.name = "Instruction"
        instruct.position = CGPoint(x: 0, y: 0)
        instruct.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        instruct.size = CGSize(width: 1334, height: 750)
        self.addChild(instruct)
    
    }
    
    func createOk() {
        let ok = SKSpriteNode(imageNamed: "ok")
        ok.name = "Ok"
        ok.zPosition = 5;
        ok.position = CGPoint(x:280, y:-140)
        ok.size = CGSize(width: 325 , height: 240)
        ok.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ok.setScale(1.1)
        self.addChild(ok)
        
    }
    
    
}



















