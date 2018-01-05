//
//  GameScene.swift
//  Duos V2
//
//  Created by amota511 on 8/16/15.
//  Copyright (c) 2015 Aaron Motayne. All rights reserved.
//



import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var greyBarTexture: SKTexture!
    var greyBarNode: SKSpriteNode!
    var blackBallTexture: SKTexture!
    var greyBallTexture: SKTexture!
    var blackBall: SKSpriteNode!
    var greyBall: SKSpriteNode!
    var BallPair: SKNode!
    var scoreLabelNode: SKLabelNode!
    var PlayLabel: SKLabelNode!
    var L1 = SKLabelNode(fontNamed:"Verdana")
    var L2 = SKLabelNode(fontNamed:"Verdana")
    var L3 = SKLabelNode(fontNamed:"Verdana")
    var stageOneButton: SKSpriteNode!
    var stageTwoButton: SKSpriteNode!
    var stageThreeButton: SKSpriteNode!
    var gameView0: GameViewController!
    
    override func didMove(to view: SKView) {
        
        
        let skyColor = SKColor(red: 96.0/255.0, green: 123.0/255.0, blue: 139.0/255.0, alpha: 1.0)
        self.backgroundColor = skyColor
        
        
        blackBallTexture = SKTexture(imageNamed: "NewPlayers1")
        blackBallTexture.filteringMode = .nearest
        
        greyBallTexture = SKTexture(imageNamed: "NewPlayers1")
        greyBallTexture.filteringMode = .nearest
        
        greyBarTexture = SKTexture(imageNamed: "Long Grey Bar ")
        greyBarTexture.filteringMode = .nearest
        greyBarNode = SKSpriteNode(texture: greyBarTexture)
        greyBarNode.setScale(1.0)
        greyBarNode.zPosition = -1
        greyBarNode.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2 )
        greyBarNode.physicsBody = SKPhysicsBody(rectangleOf: greyBarNode.size)
        greyBarNode.physicsBody?.isDynamic = false
        self.addChild(greyBarNode)
        
        
        
        let userDefaults = UserDefaults()
        //var highScore = userDefaults.integerForKey("Highest Score")
        let showHighScore = userDefaults.integer(forKey: "Highest Score")
        
        
        scoreLabelNode = SKLabelNode(fontNamed:"Verdana")
        scoreLabelNode.position = CGPoint( x: self.frame.midX, y: self.frame.size.height / 6 )
        scoreLabelNode.zPosition = 100
        scoreLabelNode.setScale(self.frame.size.height / 1110)
        scoreLabelNode.text = String("Highest Score: \(showHighScore)")
        self.addChild(scoreLabelNode)
        
        
        
        PlayLabel = SKLabelNode(fontNamed:"Verdana")
        PlayLabel.position = CGPoint(x: self.frame.midX, y: self.frame.size.height / 2.5)
        PlayLabel.zPosition = 100
        PlayLabel.setScale(self.frame.size.height / 1110)
        PlayLabel.text = String("Select Level:")
        self.addChild(PlayLabel)
        
        
        let placeBalls = SKAction.run({() in self.Players()})
        self.run(placeBalls)
        
        
        let levelOneButton = SKTexture(imageNamed: "Stage1")
        levelOneButton.filteringMode = .nearest
        stageOneButton = SKSpriteNode(texture: levelOneButton)
        stageOneButton.setScale(self.frame.size.height / 1110)
        stageOneButton.zPosition = 10
        stageOneButton.position = CGPoint(x: self.frame.midX - 150,y: self.frame.size.height / 3.35 )
        self.addChild(stageOneButton)
        
        
        let levelTwoButton = SKTexture(imageNamed: "Stage2")
        levelTwoButton.filteringMode = .nearest
        stageTwoButton = SKSpriteNode(texture: levelTwoButton)
        stageTwoButton.setScale(self.frame.size.height / 1110)
        stageTwoButton.zPosition = 10
        stageTwoButton.position = CGPoint(x: self.frame.midX,y: self.frame.size.height / 3.35 )
        self.addChild(stageTwoButton)
        
        
        let levelThreeButton = SKTexture(imageNamed: "Stage3")
        levelThreeButton.filteringMode = .nearest
        stageThreeButton = SKSpriteNode(texture: levelThreeButton)
        stageThreeButton.setScale(self.frame.size.height / 1110)
        stageThreeButton.zPosition = 10
        stageThreeButton.position = CGPoint(x: self.frame.midX + 150,y: self.frame.size.height / 3.35 )
        self.addChild(stageThreeButton)
        
        
        
        
        let DLabel = SKLabelNode(fontNamed: "Verdana")
        DLabel.position = CGPoint(x: self.frame.midX - 50, y: 3 * self.frame.height / 4)
        DLabel.zPosition = 100
        DLabel.setScale(self.frame.size.height / 1110)
        DLabel.text = String("D")
        let SMoveUp = SKAction.moveTo(y: self.frame.midY + 210, duration: 2.5)
        let SMoveDown = SKAction.moveTo(y: self.frame.midY + 160, duration: 2.5)
        let moveS = SKAction.repeatForever(SKAction.sequence([SMoveUp,SMoveDown]))
        DLabel.run(moveS)
        self.addChild(DLabel)
        
        let ULabel = SKLabelNode(fontNamed: "Verdana")
        ULabel.position = CGPoint(x: self.frame.midX - 5, y: 3 * self.frame.height / 4)
        ULabel.zPosition = 100
        ULabel.setScale(self.frame.size.height / 1110)
        ULabel.text = String("U")
        let pauseP = SKAction.wait(forDuration: TimeInterval(0.4))
        let PMoveUp = SKAction.moveTo(y: self.frame.midY + 210, duration: 2.5)
        let PMoveDown = SKAction.moveTo(y: self.frame.midY + 160, duration: 2.5)
        let moveP = SKAction.repeatForever(SKAction.sequence([PMoveUp,PMoveDown]))
        let MovingP = SKAction.sequence([pauseP,moveP])
        ULabel.run(MovingP)
        self.addChild(ULabel)
        
        let OLabel = SKLabelNode(fontNamed: "Verdana")
        OLabel.position = CGPoint(x: self.frame.midX + 43 , y: 3 * self.frame.height / 4)
        OLabel.zPosition = 100
        OLabel.setScale(self.frame.size.height / 1110)
        OLabel.text = String("O")
        let pauseL = SKAction.wait(forDuration: TimeInterval(0.8))
        let LMoveUp = SKAction.moveTo(y: self.frame.midY + 210, duration: 2.5)
        let LMoveDown = SKAction.moveTo(y: self.frame.midY + 160, duration: 2.5)
        let moveL = SKAction.repeatForever(SKAction.sequence([LMoveUp,LMoveDown]))
        let MovingL = SKAction.sequence([pauseL,moveL])
        OLabel.run(MovingL)
        self.addChild(OLabel)
        
        let SLabel = SKLabelNode(fontNamed: "Verdana")
        SLabel.position = CGPoint(x: self.frame.midX + 90, y: 3 * self.frame.height / 4)
        SLabel.zPosition = 100
        SLabel.setScale(self.frame.size.height / 1110)
        SLabel.text = String("S")
        let pauseI = SKAction.wait(forDuration: TimeInterval(1.2))
        let IMoveUp = SKAction.moveTo(y: self.frame.midY + 210, duration: 2.5)
        let IMoveDown = SKAction.moveTo(y: self.frame.midY + 160, duration: 2.5)
        let moveI = SKAction.repeatForever(SKAction.sequence([IMoveUp,IMoveDown]))
        let MovingI = SKAction.sequence([pauseI,moveI])
        SLabel.run(MovingI)
        self.addChild(SLabel)
        
        
        
    }
    
    func Players() {
        BallPair = SKNode()
        BallPair.position = CGPoint(x: self.frame.size.width / 2 - 35, y: 0)
        BallPair.zPosition = -10
        
        //let pause = SKAction.waitForDuration(NSTimeInterval(1.0))
        
        greyBall = SKSpriteNode(texture: greyBallTexture)
        greyBall.setScale(0.6)
        greyBall.position = CGPoint(x: self.frame.size.width / 2 - 875, y: self.frame.size.height / 2 - 70)
        
        greyBall.physicsBody = SKPhysicsBody(texture: greyBallTexture, size: greyBall.size)
        greyBall.physicsBody!.isDynamic = true
        greyBall.physicsBody!.allowsRotation = false
        greyBall.physicsBody!.affectedByGravity = false
        
        let GreyBallMoveUp = SKAction.moveTo(y: self.frame.size.height / 2 - 190, duration: 3.5)
        let GreyBallMoveDown = SKAction.moveTo(y: self.frame.size.height / 2 - 65, duration: 3.5)
        let makeGravity = SKAction.repeatForever(SKAction.sequence([GreyBallMoveUp,GreyBallMoveDown]))
        greyBall.run(makeGravity)
        BallPair.addChild(greyBall)
        
        blackBall = SKSpriteNode(texture: blackBallTexture)
        blackBall.setScale(0.6)
        blackBall.position = CGPoint(x: self.frame.size.width / 2 - 875, y: self.frame.size.height / 2 + 70)
        
        blackBall.physicsBody = SKPhysicsBody(texture: blackBallTexture, size: blackBall.size)
        blackBall.physicsBody!.isDynamic = true
        blackBall.physicsBody!.allowsRotation = false
        blackBall.physicsBody!.affectedByGravity = false
        
        let BlackBallMoveUp = SKAction.moveTo(y: self.frame.size.height / 2 + 190, duration: 3.5)
        let BlackBallMoveDown = SKAction.moveTo(y: self.frame.size.height / 2 + 65, duration: 3.5)
        let makeAntiGravity = SKAction.repeatForever(SKAction.sequence([BlackBallMoveUp,BlackBallMoveDown]))
        blackBall.run(makeAntiGravity)
        BallPair.addChild(blackBall)
        
        
        self.addChild(BallPair)
        
    }
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            
            
            
            
            if self.atPoint(location) == self.stageOneButton{
                
            
                self.gameView0.levelOneFunc()
                
                
            }
            
            
            if self.atPoint(location) == self.stageTwoButton{
                
                self.gameView0.levelTwoFunc()
                
            }
            
            if self.atPoint(location) == self.stageThreeButton{
                
                self.gameView0.levelThreeFunc()
                
            }
            
        }
        
    }
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        
        
        
        
    }
    
}

