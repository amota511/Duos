//
//  GameFinished.swift
//  Duos V2
//
//  Created by amota511 on 8/20/15.
//  Copyright (c) 2015 Aaron Motayne. All rights reserved.
//

import SpriteKit


class GameOver: SKScene, SKPhysicsContactDelegate {
    
    var L1 = SKLabelNode(fontNamed:"Verdana")
    var L2 = SKLabelNode(fontNamed:"Verdana")
    var L3 = SKLabelNode(fontNamed:"Verdana")
    var stageOneButton: SKSpriteNode!
    var stageTwoButton: SKSpriteNode!
    var stageThreeButton: SKSpriteNode!
    var homeButton: SKSpriteNode!
    var homeButton2: SKSpriteNode!
    var selectmusic = SKLabelNode(fontNamed: "Verdana")
    
    var gameView4: GameViewController!
    
    override func didMove(to view: SKView) {
        
        let skyColor = SKColor(red: 96.0/255.0, green: 123.0/255.0, blue: 139.0/255.0, alpha: 1.0)
        self.backgroundColor = skyColor
        
        
        let userDefaults = UserDefaults()
        
        
        let ShowAD = userDefaults.integer(forKey: "AdNumber")
        userDefaults.set(ShowAD + 1, forKey: "AdNumber")
        
        if ShowAD >= 2 {
            //gameView4.showAd(UIButton())
        }
        
        
        
        
        let levelOneButton = SKTexture(imageNamed: "Stage1")
        levelOneButton.filteringMode = .nearest
        stageOneButton = SKSpriteNode(texture: levelOneButton)
        stageOneButton.setScale(self.frame.size.height / 600)
        stageOneButton.zPosition = 10
        stageOneButton.position = CGPoint(x: self.frame.size.width - self.frame.size.width / 12.5,  y: self.frame.size.height / 4.3 )
        self.addChild(stageOneButton)
        
        
        
        
        
        let levelTwoButton = SKTexture(imageNamed: "Stage2")
        levelTwoButton.filteringMode = .nearest
        stageTwoButton = SKSpriteNode(texture: levelTwoButton)
        stageTwoButton.setScale(self.frame.size.height / 600)
        stageTwoButton.zPosition = 10
        stageTwoButton.position = CGPoint(x: self.frame.size.width - self.frame.size.width / 12.5,  y: self.frame.size.height / 2 )
        self.addChild(stageTwoButton)
        
        

        let levelThreeButton = SKTexture(imageNamed: "Stage3")
        levelThreeButton.filteringMode = .nearest
        stageThreeButton = SKSpriteNode(texture: levelThreeButton)
        stageThreeButton.setScale(self.frame.size.height / 600)
        stageThreeButton.zPosition = 10
        stageThreeButton.position = CGPoint(x: self.frame.size.width - self.frame.size.width / 12.5,  y: self.frame.size.height / 1.3 )
        self.addChild(stageThreeButton)
        
        
        let backButton = SKTexture(imageNamed: "Home")
        backButton.filteringMode = .nearest
        homeButton = SKSpriteNode(texture: backButton)
        homeButton.setScale(self.frame.size.height / 900)
        homeButton.zPosition = 10
        homeButton.position = CGPoint(x: self.frame.size.width / 13,  y: self.frame.size.height / 5.3 )
        self.addChild(homeButton)
        
        let backButton2 = SKTexture(imageNamed: "Home")
        backButton2.filteringMode = .nearest
        homeButton2 = SKSpriteNode(texture: backButton2)
        homeButton2.setScale(self.frame.size.height / 900)
        homeButton2.zPosition = 10
        homeButton2.position = CGPoint(x: self.frame.size.width / 13,  y: self.frame.size.height / 1.3 )
        self.addChild(homeButton2)
        
        
        
        let showCurrentScore = userDefaults.integer(forKey: "Score")
        let showCurrentScore2 = userDefaults.integer(forKey: "Score2")
        let showCurrentScore3 = userDefaults.integer(forKey: "Score3")
        let totalScore = showCurrentScore + showCurrentScore2 + showCurrentScore3
        
        let gameOverScore = SKLabelNode(fontNamed: "Verdana")
        gameOverScore.setScale(1.0)
        gameOverScore.position = CGPoint(x: self.frame.midX, y: self.frame.height / 1.25)
        gameOverScore.zPosition = 100
        gameOverScore.text = String("Score: \(totalScore)")
        
        
        let selectLevel = SKLabelNode(fontNamed: "Verdana")
        selectLevel.setScale(1.0)
        selectLevel.position = CGPoint(x: self.frame.midX, y: self.frame.height / 4)
        selectLevel.zPosition = 100
        selectLevel.text = String("Select Level:")
        self.addChild(selectLevel)
        
        
        selectmusic.setScale(1.0)
        selectmusic.position = CGPoint(x: self.frame.midX, y: self.frame.height / 7)
        selectmusic.zPosition = 100
        selectmusic.text = String("music on/off:")
        
        addChild(selectmusic)
        
        let highScore = userDefaults.integer(forKey: "Highest Score")
        if (totalScore > highScore) {
            userDefaults.set(totalScore, forKey: "Highest Score")
        }
        let highestScore = userDefaults.integer(forKey: "Highest Score")
        
        
        
        userDefaults.set(0, forKey: "Score")
        userDefaults.set(0, forKey: "Score2")
        userDefaults.set(0, forKey: "Score3")
        
        
        let highScoreLabel = SKLabelNode(fontNamed: "Verdana")
        highScoreLabel.setScale(1.0)
        highScoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.height / 1.4)
        highScoreLabel.zPosition = 100
        highScoreLabel.text = String("Highest Score: \(highestScore)")
        
        let gameOverNode = SKLabelNode(fontNamed: "Verdana")
        //gameOverNode = CGSize(width: self.view!.frame.width / 3, height: self.view?.frame.height / 12)//CGRect(x: self.frame.midX, y: self.frame.midY + (self.frame.height / 100), width: self.view!.frame.width / 3, height: self.view?.frame.height / 12)
        gameOverNode.fontSize = 65
        gameOverNode.position = CGPoint(x: frame.midX, y: frame.midY)
        gameOverNode.zPosition = 100
        gameOverNode.text = "Try Again!"
        
        //let winner = SKLabelNode(fontNamed: "Chalkduster")
        
        addChild(gameOverNode)
        
        
        addChild(highScoreLabel)
        addChild(gameOverScore)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if self.atPoint(location) == self.stageOneButton{
                
                self.gameView4.levelOneFunc()
                
            }
            
            
            if self.atPoint(location) == self.stageTwoButton{
                
                self.gameView4.levelTwoFunc()
                
            }
            
            if self.atPoint(location) == self.stageThreeButton{
                
                self.gameView4.levelThreeFunc()
                
            }
            
            if self.atPoint(location) == self.homeButton{
                
                self.gameView4.GameStartFunc()
            }
            
            if self.atPoint(location) == self.homeButton2{
                
                self.gameView4.levelEndlessFunc()
            }
            
            if self.atPoint(location) == self.selectmusic{
                
               self.gameView4.musicControlFunction()
            }
            
        }
        
    }
    
    
    
    
}
