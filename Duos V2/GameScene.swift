//
//  GameScene.swift
//  Duos V2
//
//  Created by amota511 on 8/16/15.
//  Copyright (c) 2015 Aaron Motayne. All rights reserved.
//



import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var startScreenNode: SKNode!
    
    var greyBarNode: SKSpriteNode!
    
    var ballOne: SKSpriteNode!
    var ballTwo: SKSpriteNode!
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
    
    var letterNodes = [SKLabelNode]()
    
    lazy var height = {
        self.frame.size.height
    }()
    
    lazy var width = {
        self.frame.size.width
    }()
 
    override func didMove(to view: SKView) {
        
        setBackground()

        createPlayers()
        createDuosLetters()
        createBar()
        createPlayLabel()
        createLevelButtons()
        createHighscoreLabel()
    }
    
    func setBackground() {
        
        let skyColor = SKColor(red: 96.0/255.0, green: 123.0/255.0, blue: 139.0/255.0, alpha: 1.0)
        self.backgroundColor = skyColor
    }
    
    func createStartScreenNode() {
        
        startScreenNode = SKNode()
        
    }
    
    func createPlayers() {
       
        let ballSize = CGSize(width: height / 20, height: height / 20)
        
        let ballOneTexture = SKTexture(imageNamed: "ballPlayer")
        
        ballOne = SKSpriteNode(texture: ballOneTexture)
        ballOne.size = ballSize
        ballOne.position = CGPoint(x: width / 7, y: height / 2 + 70)
        ballOne.zPosition = -1
        
        createBallPhysicsBody(ballPlayer: ballOne)
        createBallGravity(ball: ballOne, isAntiGravity: false)
        
        let ballTwoTexture = SKTexture(imageNamed: "ballPlayer")
        ballTwo = SKSpriteNode(texture: ballTwoTexture)
        ballTwo.size = ballSize
        ballTwo.position = CGPoint(x: width / 7, y: height / 2 - 70)
        
        createBallPhysicsBody(ballPlayer: ballTwo)
        createBallGravity(ball: ballTwo, isAntiGravity: true)
        
    }
    
    func createBallGravity(ball: SKSpriteNode, isAntiGravity: Bool) {
        
        //if antiGravity == true use a negative number to move the ball first up then down instead of the down then up
        let sign = isAntiGravity ? -1 : 1
        
        //Actions to move ballPlayers up and down
        let ballMoveUp = SKAction.moveTo(y: height / 2 + CGFloat(sign * 190), duration: 3.5)
        let ballMoveDown = SKAction.moveTo(y: height / 2 + CGFloat(sign * 65), duration: 3.5)
        
        //create an infinte loop of the animation
        let gravity = SKAction.repeatForever(SKAction.sequence([ballMoveUp, ballMoveDown]))
        ball.run(gravity)
        
        addChild(ball)
    }
    
    func createBallPhysicsBody(ballPlayer: SKSpriteNode) {
        
        ballPlayer.physicsBody = SKPhysicsBody(texture: ballPlayer.texture!, size: ballPlayer.size)
        ballPlayer.physicsBody!.isDynamic = true
        ballPlayer.physicsBody!.allowsRotation = false
        ballPlayer.physicsBody!.affectedByGravity = false
    }
    
    func createDuosLetters() {
        
        let DLabel = createLetter(letter: "D", xOffset: -50, pauseInterval: 0)
        self.addChild(DLabel)
        
        let ULabel = createLetter(letter: "U", xOffset: -5, pauseInterval: 0.4)
        self.addChild(ULabel)
        
        let OLabel = createLetter(letter: "O", xOffset: 43, pauseInterval: 0.8)
        self.addChild(OLabel)
        
        let SLabel = createLetter(letter: "S", xOffset: 90, pauseInterval: 1.2)
        self.addChild(SLabel)
        
        letterNodes.append(contentsOf: [DLabel, ULabel, OLabel, SLabel])
    }
    
    func createLetter(letter: String, xOffset: Int, pauseInterval : CGFloat) -> SKLabelNode {
        
        let letterLabel = SKLabelNode(fontNamed: "Verdana")
        letterLabel.position = CGPoint(x: self.frame.midX + CGFloat(xOffset), y: 3 * self.frame.height / 4)
        letterLabel.setScale(self.frame.size.height / 1110)
        letterLabel.text = letter
        
        let pauseLetter = SKAction.wait(forDuration: TimeInterval(pauseInterval))
        let moveLetterUp = SKAction.moveTo(y: self.frame.midY + 210, duration: 2.5)
        let moveLetterDown = SKAction.moveTo(y: self.frame.midY + 160, duration: 2.5)
        let moveLetter = SKAction.repeatForever(SKAction.sequence([moveLetterUp, moveLetterDown]))
        let movingLetter = SKAction.sequence([pauseLetter,moveLetter])
        
        letterLabel.run(movingLetter)
        
        return letterLabel
    }
    
    func createBar() {
        
        let greyBarTexture = SKTexture(imageNamed: "Long Grey Bar ")
        greyBarTexture.filteringMode = .nearest
        greyBarNode = SKSpriteNode(texture: greyBarTexture)
        greyBarNode.setScale(1.0)
        greyBarNode.zPosition = -1
        greyBarNode.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2 )
        greyBarNode.physicsBody = SKPhysicsBody(rectangleOf: greyBarNode.size)
        greyBarNode.physicsBody?.isDynamic = false
        self.addChild(greyBarNode)
    }
    
    func createPlayLabel() {

        PlayLabel = SKLabelNode(fontNamed:"Verdana")
        PlayLabel.position = CGPoint(x: self.frame.midX, y: self.frame.size.height / 2.5)
        PlayLabel.zPosition = 100
        PlayLabel.setScale(self.frame.size.height / 1110)
        PlayLabel.text = String("Select Level:")
        self.addChild(PlayLabel)
    }
    
    func createLevelButtons() {
        
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
    }
    
    func createHighscoreLabel() {
        
        let highestScore = UserDefaults().integer(forKey: "Highest Score")
        
        
        scoreLabelNode = SKLabelNode(fontNamed:"Verdana")
        scoreLabelNode.position = CGPoint( x: self.frame.midX, y: self.frame.size.height / 6 )
        scoreLabelNode.zPosition = 100
        scoreLabelNode.setScale(self.frame.size.height / 1110)
        scoreLabelNode.text = String("Highest Score: \(highestScore)")
        self.addChild(scoreLabelNode)
    }
    
    func removeStartScreen() {
        
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

