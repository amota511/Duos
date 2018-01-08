//
//  GameScene.swift
//  Duos V2
//
//  Created by amota511 on 8/16/15.
//  Copyright (c) 2015 Aaron Motayne. All rights reserved.
//



import SpriteKit

//Home Screen
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var parentViewController: GameViewController!
    
    /**************************Home Screen**************************/
    var hasRemovedHomeScreen = false
    
    var barNode: SKSpriteNode!
    var ballOne: SKSpriteNode!
    var ballTwo: SKSpriteNode!
    
    var playLabel: SKLabelNode!
    var letterNodes = [SKLabelNode]()
    
    lazy var height = {
        self.frame.size.height
    }()
    
    lazy var width = {
        self.frame.size.width
    }()
    
    /**************************Play Screen**************************/
    var score = 0
    var scoreLabelNode: SKLabelNode!
    var gameIsPlaying = false
    
    lazy var distanceToMove = {
        CGFloat(-self.frame.size.width - 2.0)
    }()
    
    var textures =
        [SKTexture(imageNamed: "Light Grey Circle"), SKTexture(imageNamed: "Dark Grey Circle"), SKTexture(imageNamed: "Light Grey Square"), SKTexture(imageNamed: "Dark Grey Square"), SKTexture(imageNamed: "Light Grey Triangle"), SKTexture(imageNamed: "Dark Grey Triangle")]
    
    var shapes = SKNode()
    var shouldRewind = false
    var shapeTravelTime: CGFloat = 8
    
    override func didMove(to view: SKView) {
        
        setBackground()

        createPlayers()
        createBar()
        //createBorders(isTopBorder: true)
        //createBorders(isTopBorder: false)
        
        createHomeScreen()
    }
    
    func setBackground() {
        
        let skyColor = SKColor(red: 96.0/255.0, green: 123.0/255.0, blue: 139.0/255.0, alpha: 1.0)
        self.backgroundColor = skyColor
        
        self.physicsWorld.contactDelegate = self
  
        addChild(shapes)
    }
    
    func createHomeScreen() {
    
        createDuosLetters()
        createPlayLabel()
    }
    
    func createPlayers() {
       
        let ballSize = CGSize(width: height / 16, height: height / 16)
        
        let ballOneTexture = SKTexture(imageNamed: "ballPlayer")
        ballOne = SKSpriteNode(texture: ballOneTexture)
        ballOne.size = ballSize
        ballOne.position = CGPoint(x: width / 7, y: height / 2 + 70)
        addChild(ballOne)

        let ballTwoTexture = SKTexture(imageNamed: "ballPlayer")
        ballTwo = SKSpriteNode(texture: ballTwoTexture)
        ballTwo.size = ballSize
        ballTwo.position = CGPoint(x: width / 7, y: height / 2 - 70)
        addChild(ballTwo)
        
        createBallPhysics()
    }
    
    func createBallPhysics() {
        
        createBallPhysicsBody(ballPlayer: ballOne)
        createBallGravity(ball: ballOne, isAntiGravity: false)
        
        createBallPhysicsBody(ballPlayer: ballTwo)
        createBallGravity(ball: ballTwo, isAntiGravity: true)
    }
    
    func createBallGravity(ball: SKSpriteNode, isAntiGravity: Bool) {
        
        //if antiGravity == true use a negative number to move the ball first up then down instead of the down then up
        let sign = isAntiGravity ? -1 : 1
        
        //Actions to move ballPlayers up and down
        let ballMoveUp = SKAction.moveTo(y: height / 2 + (CGFloat(sign) * (height / 3)), duration: 3.5)
        let ballMoveDown = SKAction.moveTo(y: height / 2 + (CGFloat(sign) * (height / 8)), duration: 3.5)
        
        //create an infinte loop of the animation
        let gravity = SKAction.repeatForever(SKAction.sequence([ballMoveUp, ballMoveDown]))
        ball.run(gravity)
    }
    
    func createBallPhysicsBody(ballPlayer: SKSpriteNode) {
        
        ballPlayer.physicsBody = SKPhysicsBody(texture: ballPlayer.texture!, size: ballPlayer.size)
        ballPlayer.physicsBody!.isDynamic = true
        ballPlayer.physicsBody!.allowsRotation = false
        ballPlayer.physicsBody!.affectedByGravity = false

        ballPlayer.physicsBody!.categoryBitMask = colliderType.player.rawValue
        ballPlayer.physicsBody!.contactTestBitMask = colliderType.shape.rawValue | colliderType.bar.rawValue
        ballPlayer.physicsBody!.collisionBitMask = colliderType.shape.rawValue | colliderType.bar.rawValue
    }
    
    func createBar() {
        
        let barTexture = SKTexture(imageNamed: "Bar")
        barNode = SKSpriteNode(texture: barTexture)
        barNode.zPosition = -1
        barNode.position = CGPoint(x: width / 2, y: height / 2 )
        barNode.physicsBody = SKPhysicsBody(rectangleOf: barNode.size)
        barNode.physicsBody!.isDynamic = false
        barNode.physicsBody!.categoryBitMask = colliderType.bar.rawValue
        barNode.physicsBody!.contactTestBitMask = colliderType.player.rawValue
        barNode.physicsBody!.collisionBitMask = colliderType.player.rawValue
        self.addChild(barNode)
    }
    
    func createBorders(isTopBorder: Bool) {
        
        let border = SKSpriteNode(texture: barNode.texture!)
        
        border.physicsBody = SKPhysicsBody(rectangleOf: barNode.size)
        border.physicsBody!.isDynamic = false
        border.physicsBody!.categoryBitMask = colliderType.bar.rawValue
        border.physicsBody!.contactTestBitMask = colliderType.player.rawValue
        border.physicsBody!.collisionBitMask = colliderType.player.rawValue
        
        border.position = isTopBorder ? CGPoint(x: self.frame.minX, y: self.frame.minY) : CGPoint(x: self.frame.minX, y: self.frame.maxY)
        
        addChild(border)
    }
    
    func createDuosLetters() {
        
        let DLabel = createLetter(letter: "D", xOffset: Int(-self.view!.frame.height * 0.1), pauseInterval: 0)
        self.addChild(DLabel)
        
        let ULabel = createLetter(letter: "U", xOffset: Int(-self.view!.frame.height * 0.035), pauseInterval: 0.4)
        self.addChild(ULabel)
        
        let OLabel = createLetter(letter: "O", xOffset: Int(self.view!.frame.height * 0.035), pauseInterval: 0.8)
        self.addChild(OLabel)
        
        let SLabel = createLetter(letter: "S", xOffset: Int(self.view!.frame.height * 0.1), pauseInterval: 1.2)
        self.addChild(SLabel)
        
        letterNodes.append(contentsOf: [DLabel, ULabel, OLabel, SLabel])
    }
    
    func createLetter(letter: String, xOffset: Int, pauseInterval : CGFloat) -> SKLabelNode {
        
        let letterLabel = SKLabelNode(fontNamed: "Verdana")
        letterLabel.position = CGPoint(x: self.frame.midX + CGFloat(xOffset), y: height * 0.85)
        letterLabel.setScale(0.5)
        letterLabel.text = letter
        
        let pauseLetter = SKAction.wait(forDuration: TimeInterval(pauseInterval))
        let moveLetterUp = SKAction.moveTo(y: height * 0.91, duration: 2.5)
        let moveLetterDown = SKAction.moveTo(y: height * 0.825, duration: 2.5)
        let moveLetter = SKAction.repeatForever(SKAction.sequence([moveLetterUp, moveLetterDown]))
        let movingLetter = SKAction.sequence([pauseLetter,moveLetter])
        
        letterLabel.run(movingLetter)
        
        return letterLabel
    }

    func createPlayLabel() {

        playLabel = SKLabelNode(fontNamed:"Verdana")
        playLabel.position = CGPoint(x: self.frame.midX, y: height * 0.05)
        playLabel.setScale(0.5)
        playLabel.text = "Tap To Start"
        self.addChild(playLabel)
    }
    
    func removeStartScreen() {
        
        //remove duos label
        for letter in letterNodes {
            
            letter.removeAllActions()
            letter.run(SKAction.moveTo(y: height + letter.fontSize, duration: 0.4), completion: {
                letter.removeFromParent()
            })
        }
        
        playLabel.run(SKAction.moveTo(y: 0 - playLabel.fontSize, duration: 0.4), completion: {
            
            self.playLabel.removeFromParent()
            
            self.gameStartCountdown()
        })
    }
    
    func gameStartCountdown() {
        
        self.parentViewController.numOfGamesPlayed += 1
        
        createNumber(num: 3)
        setPlayersToStartPosition(ball: ballOne, isTopPlayer: true)
        setPlayersToStartPosition(ball: ballTwo, isTopPlayer: false)
    }
    
    func createNumber(num : Int) {
        
        let number = SKLabelNode(fontNamed: "Verdana")
        number.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 15)
        number.setScale(3)
        number.text = num == 0 ? "Go!" : String(num)
        number.fontColor = SKColor.lightText
        
        
        addChild(number)
        
        number.run(SKAction.sequence([SKAction.scale(by: 1.05, duration: 0.1), SKAction.fadeOut(withDuration: 0.9)])) {
            
            number.removeFromParent()
            
            if number.text == "Go!" {
                self.startGame()
            } else {
                
                self.createNumber(num: num - 1)
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
           
            let location = touch.location(in: self)
 
            if !hasRemovedHomeScreen {
                
                self.removeStartScreen()
                hasRemovedHomeScreen = true
            } else if gameIsPlaying {
                
                applyForceOnBall(ball: ballOne, isTopPlayer: true)
                applyForceOnBall(ball: ballTwo, isTopPlayer: false)
            } else if shouldRewind {
                
                for shape in shapes.children {
                    shape.removeAllActions()
                }
                shouldRewind = false
                removeAllActions()
                shapes.isPaused = false
                
                run(SKAction.run {
                    for shape in self.shapes.children {
                        self.rewindAndRemoveShape(shape: shape)
                    }
                    }, completion: {
                        print("The shapes have been removed")

                        self.createBallPhysics()
                        
                        self.gameStartCountdown()
                        
                })
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        if gameIsPlaying {
            
            createGravities(ball: ballOne, isTopPlayer: true)
            createGravities(ball: ballTwo, isTopPlayer: false)
            
            if speed < 21 {
                speed += 0.0006
            }
            
            if shapeTravelTime > 5 {
                shapeTravelTime -= 0.0005
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //The player has made contact with the score Node which is invisible and in the empty spaces between both the moving obstacles and the obstalce and the borders
        if (contact.bodyA.categoryBitMask & colliderType.score.rawValue) == colliderType.score.rawValue ||  (contact.bodyB.categoryBitMask & colliderType.score.rawValue) == colliderType.score.rawValue {
            
            //User has scored a point
            score += 1
            scoreLabelNode.text = String(score / 2)
            
            scoreLabelNode.run(SKAction.sequence([SKAction.scale(to: 1.5, duration:TimeInterval(0.1)), SKAction.scale(to: 1.0, duration:TimeInterval(0.1))]))
            
        }else {

            //User Has Lost
            
            
            if gameIsPlaying {
                
                shapes.isPaused = true
                shouldRewind = true
                gameIsPlaying = false
                
                removeAllActions()
                
                speed = 1.0
                shapeTravelTime = 8
                score = 0
            }
            
            //Show Ad
            parentViewController.gameOverFunc()
            
            //Show dead screen
            
        }
    }
}

//Play Screen
extension GameScene {
    
    enum colliderType: UInt32 {
        case player = 1
        case shape = 2
        case bar = 3
        case score = 4
    }
    
    enum shapeType: UInt32 {
        case circle = 0
        case square = 1
        case triangle = 2
    }
    
    func startGame() {
        setScoreLabel()
        gameIsPlaying = true
        spawnShapes()
    }
    
    func setPlayersToStartPosition(ball: SKSpriteNode, isTopPlayer: Bool) {
        
        ball.removeAllActions()
        
        let sign = isTopPlayer ? 1 : -1
        let moveToYStartPosition = SKAction.moveTo(y: height / 2 + (CGFloat(sign) * (height / 3)), duration: 0.5)
        let moveToXStartPosition = SKAction.moveTo(x: width / 7, duration: 0.5)
        
        ball.run(SKAction.sequence([moveToYStartPosition, moveToXStartPosition]), completion: {
            print("balls set")
            ball.removeAllActions()
        })
    }
    
    func setScoreLabel() {
        
        if scoreLabelNode == nil {
            scoreLabelNode = SKLabelNode(fontNamed: "Verdana")
            scoreLabelNode.position = CGPoint(x: self.frame.midX, y: height * 0.85)
            scoreLabelNode.zPosition = 100
            scoreLabelNode.setScale(0.7)
            scoreLabelNode.text = String(score)
            addChild(scoreLabelNode)
        } else {
            scoreLabelNode.text = String(score)
        }
        
    }
    
    func createGravities(ball: SKSpriteNode, isTopPlayer: Bool) {
        
        let sign = isTopPlayer ? -1 : 1
        ball.physicsBody?.applyForce(CGVector(dx: 0.0, dy: CGFloat(sign) * 5))
    }
    
    func applyForceOnBall(ball: SKSpriteNode, isTopPlayer: Bool) {
        
        let sign = isTopPlayer ? 1 : -1
        ball.physicsBody!.velocity = CGVector(dx: 0, dy: height / (CGFloat(sign) * 3))
    }
    
    func spawnShapes() {
        
        let generateShape = SKAction.run({() in self.generateShape()})
        let pauseGenerator = SKAction.wait(forDuration: TimeInterval(2))
        let generateShapesForever = SKAction.repeatForever(SKAction.sequence([generateShape, pauseGenerator]))
        
        run(generateShapesForever)
    }
    
    func generateShape() {
        
        let index = Int(arc4random_uniform(3)) * 2
      
        let shapeGap = self.height * 0.4
        
        let shapePair = SKNode()
        shapePair.position = CGPoint(x: width, y: 0)
        shapePair.zPosition = -10
        
        let height = UInt32(self.height * 0.4)
        let y = CGFloat(arc4random_uniform(height) + UInt32(self.height * 0.035))
        
        let topShape = SKSpriteNode(texture: textures[index])
        topShape.setScale(0.2)
        topShape.position = CGPoint(x: 0.0, y: CGFloat(y))
        
        topShape.physicsBody = SKPhysicsBody(texture: textures[index], size: topShape.size)
        topShape.physicsBody!.isDynamic = false
        topShape.physicsBody!.categoryBitMask = colliderType.shape.rawValue
        topShape.physicsBody!.contactTestBitMask = colliderType.player.rawValue
        topShape.physicsBody!.collisionBitMask = colliderType.player.rawValue
        
        shapePair.addChild(topShape)
        
        let bottomShape = SKSpriteNode(texture: textures[index + 1])
        bottomShape.setScale(0.2)
        bottomShape.position = CGPoint(x: 0.0, y: y + bottomShape.frame.size.height + shapeGap)
        
        bottomShape.physicsBody = SKPhysicsBody(texture: textures[index + 1], size: bottomShape.size)
        bottomShape.physicsBody!.isDynamic = false
        bottomShape.physicsBody!.categoryBitMask = colliderType.shape.rawValue
        bottomShape.physicsBody!.contactTestBitMask = colliderType.player.rawValue
        bottomShape.physicsBody!.collisionBitMask = colliderType.player.rawValue
        
        shapePair.addChild(bottomShape)
        
        let scoreContactNode = SKNode()
        scoreContactNode.position = CGPoint(x: bottomShape.size.width + ballOne.size.width / 2, y: self.frame.minY )
        scoreContactNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: topShape.size.width, height: self.height))
        scoreContactNode.physicsBody!.isDynamic = false
        scoreContactNode.physicsBody!.categoryBitMask = colliderType.score.rawValue
        scoreContactNode.physicsBody!.contactTestBitMask = colliderType.player.rawValue
        shapePair.addChild(scoreContactNode)

        shapePair.run(moveAndRemoveShape(index: index)) {
            print("shape removed after it left the screen")
        }
        
        shapes.addChild(shapePair)
    }
    
    func moveAndRemoveShape(index: Int) -> SKAction{
        
        let moveShape = SKAction.moveBy(x: distanceToMove, y: 0.0, duration: TimeInterval(shapeTravelTime))
        let removeShape = SKAction.removeFromParent()
        
        return SKAction.sequence([moveShape, removeShape])
    }
    
    func rewindAndRemoveShape(shape: SKNode) {
        
        let distanceToRewind = (width - shape.position.x) + textures[0].size().width
        
        let moveShape = SKAction.moveBy(x: distanceToRewind, y: 0.0, duration: TimeInterval(1))
        let removeShape = SKAction.removeFromParent()

        shape.run(SKAction.sequence([moveShape, removeShape])) {
            print("shape removed")
        }
    }
}

//Dead Screen
extension GameScene {

    func removeShapes() {
        
    }
}
