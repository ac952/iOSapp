//
//  GameplayScene.swift
//  FirstAppGame
//
//  Created by Aileen Cai on 8/12/17.
//  Copyright © 2017 aileen. All rights reserved.
//

//Disclaimer: I don't own any of the assets/artwork for this app
//I got my images from the makeschoolacademy page and awesometuts free asset download via udemy
//image for lettuce
//https://cdn.dribbble.com/users/579540/screenshots/2149115/ad_punlettuce_1x.png
//image for coin
//http://www.istockphoto.com/vector/dollar-coins-rotation-gm501700128-81479385?esource=SEO_GIS_CDN_Redirect


import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
//    refering to class Player in player.swift
    var player = Player();
    
//    limit number of jumps
    var Jump = false;
    
    var obstacles = [SKSpriteNode]();
    
    var gameStart = false;
    
    var Alive = false;
    
//    stop moving obstacle and points when player dies
    var stopMovingObjects = Timer();
    var stopMovingPoints = Timer();
    
    //create score with special font
    var score = SKLabelNode(fontNamed: "04b_19");
//    starting score
    var countingScore = 0;
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    override func update(_ currentTime: TimeInterval) {
//        moveBackground();
//        only move background if player is alive
        if Alive == true {
            moveBackground();
            
        }
        
        playerOutOfBounds();
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //if gameStart == false {
            //Alive = true;
            //gameStart = true;
        //}
        
        
        
        
        
        
//        player.jump();
        
//        allow player to jump off of carrot
        if Jump == true {
            Jump = false;
            player.jump();
            
        }
        
        for touch in touches {
            //get location in gameplayscene
            let location = touch.location(in: self);
            
            if atPoint(location).name == "Restart" {
                //restart game
            let gameplay = GameplayScene(fileNamed: "GameplayScene")
            gameplay!.scaleMode = .aspectFill;
            self.view?.presentScene(gameplay!, transition: SKTransition.doorway(withDuration: 1.5));
           
                
            }
        
            if atPoint(location).name == "Quit" {
            // go to main menu
            let mainMenu = MainMenuScene(fileNamed: "MainMenuScene");
            mainMenu?.scaleMode = .aspectFit
            self.view?.presentScene(mainMenu!, transition: SKTransition.doorway(withDuration: TimeInterval(1)));
        
            }
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
            Jump = true;
        }
        
//        if player lands onto obstacle, it will die
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Obstacle" {
            Jump = false;
            
//            kill player
            if Alive == true {
                playerDies();
            }
            
            
        }
        
//        if player lands on carrot, it can jump again
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Carrot" {
            Jump = true;
            
        }
        
//        if player collides with coin, remove it from scene
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Lettuce"{
            
//            player gains 1 point
            countingScore += 1;
            score.text = String(countingScore);
            secondBody.node?.removeFromParent();
        
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Beet"{
           
//            player gains 5 points
            countingScore += 5;
            score.text = String(countingScore);
            secondBody.node?.removeFromParent();
        }
        
    }
    
    
    func initialize() {
        
        // calls these when pressing restart
        // need to start score to 0, otherwise game will resume prev score
        gameStart = false;
        Alive = false;

        physicsWorld.contactDelegate = self;
        
        createBackground();
        createGround();
        createClouds();
        createPlayer();
        createObstacle();
        
        //spawnPoints();
        
        
//        call obstacles infinitely (repeat)
//        spawn obstacle every two seconds
        
//        Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.spawnObstacle), userInfo: nil, repeats: true);
        
        
//        randomized spawning obstacle
        stopMovingObjects = Timer.scheduledTimer(timeInterval: TimeInterval(randomBetweenTwoNumbers(firstNumber: 2.5, secondNumber: 3)), target: self, selector: #selector(GameplayScene.spawnObstacle), userInfo: nil, repeats: true);
        
        
//        randomize spawning points
        stopMovingPoints = Timer.scheduledTimer(timeInterval: TimeInterval(randomBetweenTwoNumbers(firstNumber: 2.5, secondNumber: 8)), target: self, selector: #selector(GameplayScene.spawnPoints), userInfo: nil, repeats: true);
        
//        spawnpoints
        stopMovingObjects = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(GameplayScene.spawnPoints), userInfo: nil, repeats: true);
       
        
        Alive = true;
        createScoreCount();
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
            
            node.position.x += 7.5;
            
            if node.position.x > (self.frame.width) {
                node.position.x -= self.frame.width * 3;
            }
        
        }));
        
        enumerateChildNodes(withName: "Ground", using: ({
            (node, error) in
            
            node.position.x -= 5.0;
            
            if node.position.x < -(self.frame.width) {
                node.position.x += self.frame.width * 3
            }
            
        }));
        
    }
    
    func createPlayer() {
        player = Player(imageNamed: "bunny1");
        player.position = CGPoint(x: -200, y: 0);
        player.initialize();
        self.addChild(player);
        
    }
    
//    change rectangle of size of donuts, make it smaller
//    vary size of obstacle, and allow bunny to jump infinitely. or only twice
    
    
//    vary height of carrot
    
    func createObstacle() {
        
        for i in 0...3 {
            let obstacle = SKSpriteNode(imageNamed: "obstacle\(i)");

            
            if i == 0 {
                obstacle.name = "Carrot";
                obstacle.setScale(0.8);
//                obstacle starting position is offscreen in x
                obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: -300);
                obstacle.size = CGSize(width: 200, height: 550);
                obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size );
                
                
//                can jump on this obstacle
            } else if i == 1 {
                obstacle.name = "Obstacle";
                obstacle.setScale(0.8);
//                 obstacle cause player death
                obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: -158);
                obstacle.physicsBody = SKPhysicsBody(circleOfRadius: obstacle.size.width / 2 );
               
                
            } else if i == 2 {
                obstacle.name = "Obstacle";
                obstacle.setScale(0.9);
                //                 obstacle cause player death
                obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: -148);
                obstacle.physicsBody = SKPhysicsBody(circleOfRadius: obstacle.size.width / 2 );
                
            } else {
                obstacle.name = "Obstacle";
                obstacle.setScale(0.65);
                //                obstacles cause player death
                obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: -170);
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
        
        
//        move obstacle toward player
        
        let move = SKAction.moveTo(x: -(self.frame.size.width * 2), duration: TimeInterval(15));
    
        let remove = SKAction.removeFromParent();
        
        let actionSequence = SKAction.sequence([move,remove]);
       obstacle.run(actionSequence);
        
        self.addChild(obstacle);
    }
    
//    randomize obstacle
    func randomBetweenTwoNumbers(firstNumber: CGFloat, secondNumber: CGFloat) -> CGFloat {
//        arc4random() returns value between 0 -> (2**32)-1
//        min(firstNum, secondNum) returns minimum value of either first or second number
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNumber - secondNumber) + firstNumber;
    }
    
    
    func spawnPoints() {
        
//        lettuce properties
        let lettuce = SKSpriteNode(imageNamed: "point1");
        lettuce.name = "Lettuce";
        lettuce.setScale(0.7);
        lettuce.position = CGPoint(x: self.frame.width + lettuce.size.width + 900, y: 80);
        lettuce.zPosition = 10;
        lettuce.anchorPoint = CGPoint(x: 0.5, y: 0.5);
//        lettuce physics = 1 point if player collides and disappear after colliding
        lettuce.physicsBody = SKPhysicsBody(circleOfRadius: lettuce.size.width / 2.1);
        lettuce.physicsBody?.affectedByGravity = false;
        lettuce.physicsBody?.isDynamic = true;
        lettuce.physicsBody?.allowsRotation = false;
        lettuce.physicsBody?.categoryBitMask = ColliderType.Lettuce;
        //lettuce.physicsBody?.collisionBitMask = ColliderType.Player | ColliderType.Ground ;
        lettuce.physicsBody?.collisionBitMask = 0;
        lettuce.physicsBody?.contactTestBitMask = ColliderType.Player;
        //        skactions-lettuce
        let moveLettuce = SKAction.moveTo(x: (-self.frame.width * 3 ), duration: TimeInterval(13));
        let removeLettuce = SKAction.removeFromParent();
        
        let lettuceAction = SKAction.sequence([moveLettuce, removeLettuce]);
        lettuce.run(lettuceAction);

//        beet properties
        let beet = SKSpriteNode(imageNamed: "point2");
        beet.name = "Beet";
        beet.setScale(0.4);
        beet.position = CGPoint(x: self.frame.width + beet.size.width + 11000, y: 180);
        beet.zPosition = 10;
        beet.anchorPoint = CGPoint(x: 0.5, y: 0.5);
//        player gains 5 points if collide with beet
//        let texturedBeet = SKSpriteNode(texture: beet);
        beet.physicsBody = SKPhysicsBody(circleOfRadius: beet.size.width/1.9);
        beet.physicsBody?.affectedByGravity = false;
        beet.physicsBody?.isDynamic = true;
        beet.physicsBody?.allowsRotation = false;
        beet.physicsBody?.categoryBitMask = ColliderType.Beet;
        beet.physicsBody?.contactTestBitMask = ColliderType.Player;
        beet.physicsBody?.collisionBitMask = 0;
        
//        SKActions-beet
//        beet takes 11 seconds to pass screen
        let moveBeet = SKAction.moveTo(x: (-self.frame.width), duration: TimeInterval(12));
        let removeBeet = SKAction.removeFromParent();
        
        let beetAction = SKAction.sequence([moveBeet, removeBeet]);
        beet.run(beetAction);
        
        self.addChild(lettuce);
        self.addChild(beet);
        
    }
    
    func playerOutOfBounds() {
        
//        if player is alive, check if player is on the screen or not
        
        if Alive == true {
            if player.position.x < -(self.frame.size.width) - 15 {
                playerDies();
            }
        }
    }
    
    func playerDies() {
        
        //save score when player dies
        let high_score = UserDefaults.standard.integer(forKey: "highscore");
        
        
        if high_score < countingScore {
            UserDefaults.standard.set(countingScore,forKey: "highscore");
        }
     
        
        player.removeFromParent();
        
        
//        remove these properties from screen when player dies and buttons pop up
        for child in children {
            if child.name == "Obstacle" || child.name == "Carrot" || child.name == "Lettuce" || child.name == "Beet" {
                child.removeFromParent();
            }
        }
        
        stopMovingObjects.invalidate();
        stopMovingPoints.invalidate();
        Alive  = false;
        
        let quitButton = SKSpriteNode(imageNamed: "Quit");
        quitButton.name = "Quit";
        quitButton.position = CGPoint(x: 250, y: 0);
        quitButton.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        quitButton.zPosition = 6;
        quitButton.setScale(0);
        
        let restartButton = SKSpriteNode(imageNamed: "Retry");
        restartButton.name = "Restart";
        restartButton.position = CGPoint(x: -250, y: 0);
        restartButton.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        restartButton.zPosition = 6;
        restartButton.setScale(0);
        
//        buttons will slowly get bigger on screen starting from scale 0
        let scaleQuitButton = SKAction.scale(to: 1, duration: TimeInterval(0.5));
        quitButton.run(scaleQuitButton);
        
        let scaleRestartButton = SKAction.scale(to: 0.85, duration: TimeInterval(0.5));
        restartButton.run(scaleRestartButton);
        
        self.addChild(restartButton);
        self.addChild(quitButton);

    }
    
//    display score in upper right corner
    func createScoreCount() {
        score.zPosition = 9;
        score.position = CGPoint(x: 540, y: 270);
        score.text = "0";
        score.fontSize = 100;
        self.addChild(score);
    }
    

    
}







