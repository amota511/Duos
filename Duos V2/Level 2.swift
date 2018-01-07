

import SpriteKit


class levelTwo: SKScene, SKPhysicsContactDelegate {
    
    var darkGreySquareTexture: SKTexture!
    var lightGreySquareTexture: SKTexture!
    var darkGreyTraingleTexture: SKTexture!
    var TriangleMoveAndRemove = SKAction()
    var TriangleMoveAndRemove1 = SKAction()
    var TriangleMoveAndRemove2 = SKAction()
    var SquareMoveAndRemove1 = SKAction()
    var SquareMoveAndRemove2 = SKAction()
    var CircleMoveAndRemove1 = SKAction()
    var CircleMoveAndRemove2 = SKAction()
    var greyBarTexture: SKTexture!
    var greyBarNode: SKSpriteNode!
    var lightGreyTriangleTexture: SKTexture!
    var SquareMoveAndRemove = SKAction()
    var darkGreyCircleTexture: SKTexture!
    var lightGreyCircleTexture: SKTexture!
    var circleMoveAndRemove = SKAction()
    var spawnShape = SKAction()
    var randomNumberShape: Int!
    var randomShape: [Int: SKAction]!
    var spawnShapes = SKAction()
    var blackBallTexture: SKTexture!
    var greyBallTexture: SKTexture!
    var blackBall: SKSpriteNode!
    var greyBall: SKSpriteNode!
    var BallPair: SKNode!
    var ball = SKAction()
    var score = NSInteger()
    var scoreLabelNode: SKLabelNode!
    var gameOverScore: SKLabelNode!
    var background: SKTexture!
    var backgroundNode: SKSpriteNode!
    var moving: SKNode!
    var shapes: SKNode!
    var gameOverNode: SKLabelNode!
    var ScreenColor: SKColor!
    var highestScore: SKLabelNode!
    
    
    var gameView2: GameViewController!
    
    
    
    
    override func didMove(to view: SKView) {
        
        
        
        
        
        let skyColor1 =  SKColor(red: 185.0/255.0, green: 195.0/255.0, blue: 115.0/255.0, alpha: 1.0)
        let skyColor2 = SKColor(red: 81.0/255.0, green: 201.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        let skyColor3 = SKColor(red: 0.0/255.0, green: 194.0/255.0, blue: 194.0/255.0, alpha: 1.0)
        let skyColor4 = SKColor(red: 153.0/255.0, green: 77.0/255.0, blue: 5.0/255.0, alpha: 1.0)
        let skyColor5 = SKColor(red: 96.0/255.0, green: 123.0/255.0, blue: 139.0/255.0, alpha: 1.0)
        let skyColor6 = SKColor(red: 122.0/255.0, green: 103.0/225.0, blue: 220.0/255.0, alpha: 1.0)
        let skyColor7 = SKColor(red: 90.0/255.0, green: 40.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        let skyColor8 = SKColor(red: 96.0/255.0, green: 123.0/255.0, blue: 139.0/255.0, alpha: 1.0)
        let skyColor9 = SKColor(red: 36.0/255.0, green: 53.0/255.0, blue: 249.0/255.0, alpha: 0.85)
        let skyColor10 = SKColor(red: 36.0/255.0, green: 173.0/255.0, blue: 10.0/255.0, alpha: 1.0)
        let skyColor11 = SKColor(red: 236.0/255.0, green: 173.0/255.0, blue: 10.0/255.0, alpha: 1.0)
        let skyColor12 = SKColor(red: 255.0/255.0, green: 153.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        let skyColor13 = SKColor(red: 255.0/255.0, green: 238.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        let skyColor14 = SKColor(red: 255.0/255.0, green: 78.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        
        let tapColor = [1:skyColor1, 2:skyColor2, 3:skyColor3, 4:skyColor4, 5: skyColor5, 6: skyColor6, 7: skyColor7, 8: skyColor8, 9:skyColor9, 10:skyColor10, 11:skyColor11, 12:skyColor12, 13: skyColor13, 14: skyColor14]
        
        let randomColor = Int(arc4random_uniform(14) + 1)
        
        let ScreenColor: SKColor! = tapColor[randomColor]
        self.backgroundColor = ScreenColor!
        
        self.physicsWorld.contactDelegate = self
        
        moving = SKNode()
        
        moving.speed = 7.0
        self.addChild(moving)
        
        shapes = SKNode()
        moving.addChild(shapes)
        
        
        
        
        let topBar = SKSpriteNode(texture: darkGreySquareTexture)
        topBar.position = CGPoint(x: 0,y: self.frame.maxY - self.frame.size.height / 17)
        topBar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 500, height: 95))
        topBar.physicsBody?.isDynamic = false
        topBar.physicsBody!.categoryBitMask = colliderType.bar.rawValue
        topBar.physicsBody!.contactTestBitMask = colliderType.player.rawValue
        topBar.physicsBody!.collisionBitMask = colliderType.player.rawValue
        
        self.addChild(topBar)
        
        let bottomBar = SKSpriteNode(texture: darkGreySquareTexture)
        bottomBar.position = CGPoint(x: 35, y: self.frame.minY - self.frame.size.height / 17)
        bottomBar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 500, height: 95))
        bottomBar.physicsBody?.isDynamic = false
        bottomBar.physicsBody?.categoryBitMask = colliderType.bar.rawValue
        bottomBar.physicsBody?.contactTestBitMask = colliderType.player.rawValue
        bottomBar.physicsBody?.collisionBitMask = colliderType.player.rawValue
        
        self.addChild(bottomBar)
        
        
        darkGreyCircleTexture = SKTexture(imageNamed: "Dark Grey Circle")
        darkGreyCircleTexture.filteringMode = .nearest
        
        lightGreyCircleTexture = SKTexture(imageNamed: "Light Grey Circle")
        lightGreyCircleTexture.filteringMode = .nearest
        
        darkGreySquareTexture = SKTexture(imageNamed: "Dark Grey Square")
        darkGreySquareTexture.filteringMode = .nearest
        
        lightGreySquareTexture = SKTexture(imageNamed: "Light Grey Square")
        lightGreySquareTexture.filteringMode = .nearest
        
        darkGreyTraingleTexture = SKTexture(imageNamed: "Dark Grey Triangle")
        darkGreyTraingleTexture.filteringMode = .nearest
        
        lightGreyTriangleTexture = SKTexture(imageNamed: "Light Grey Triangle")
        lightGreyTriangleTexture.filteringMode = .nearest
        
        blackBallTexture = SKTexture(imageNamed: "NewPlayers")
        blackBallTexture.filteringMode = .nearest
        
        greyBallTexture = SKTexture(imageNamed: "NewPlayers")
        greyBallTexture.filteringMode = .nearest
        
        greyBarTexture = SKTexture(imageNamed: "Long Grey Bar ")
        greyBarTexture.filteringMode = .nearest
        
        greyBarNode = SKSpriteNode(texture: greyBarTexture)
        greyBarNode.setScale(1.0)
        greyBarNode.zPosition = -1
        greyBarNode.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2 )
        
        greyBarNode.physicsBody = SKPhysicsBody(rectangleOf: greyBarNode.size)
        
        greyBarNode.physicsBody!.isDynamic = false
        greyBarNode.physicsBody!.categoryBitMask = colliderType.bar.rawValue
        greyBarNode.physicsBody!.contactTestBitMask = colliderType.player.rawValue
        greyBarNode.physicsBody!.collisionBitMask = colliderType.player.rawValue
        self.addChild(greyBarNode)
        
        
        
        
        
        
        spawnShapes = SKAction.run({() in self.Shape()})
        
        
        let delayShape = SKAction.wait(forDuration: TimeInterval(0.7))
        let spawnThenDelayShape = SKAction.sequence([spawnShapes,delayShape])
        let spawnThenDelayShapeForever = SKAction.repeat(spawnThenDelayShape, count: 16)
        
        self.run(spawnThenDelayShapeForever)
        
        
        
        let distanceToMove = CGFloat(self.frame.size.width + 2.0)
        
        let moveCircle = SKAction.moveBy(x: -distanceToMove * darkGreyCircleTexture.size().width, y: 0.0, duration: TimeInterval(2.0 * distanceToMove))
        let removeCircle = SKAction.removeFromParent()
        circleMoveAndRemove = SKAction.sequence([moveCircle, removeCircle])
        
        
        let moveCircle1 = SKAction.move(to: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 6), duration: TimeInterval(8.0))
        let removeCircle1 = SKAction.move(to: CGPoint(x: self.frame.size.width - self.frame.size.width - 30, y: self.frame.size.height - self.frame.size.height), duration: TimeInterval(7.0))
        CircleMoveAndRemove1 = SKAction.sequence([moveCircle1,removeCircle1])
        
        
        let moveSquare = SKAction.moveBy(x: -distanceToMove * darkGreySquareTexture.size().width, y: 0.0, duration: TimeInterval(2.0 * distanceToMove))
        let removeSquare = SKAction.removeFromParent()
        SquareMoveAndRemove = SKAction.sequence([moveSquare, removeSquare])
        
        
        let moveSquare1 = SKAction.move(to: CGPoint(x: 0.0, y: self.frame.size.height ), duration: TimeInterval(13.0))
        let removeSquare1 = SKAction.move(to: CGPoint(x: 0.0 , y: self.frame.size.height - self.frame.size.height), duration: TimeInterval(13.0))
        SquareMoveAndRemove1 = SKAction.sequence([moveSquare1,removeSquare1])
        let moveSquare2 = SKAction.move(to: CGPoint(x: 0.0, y: self.frame.size.height - self.frame.size.height), duration: TimeInterval(13.0))
        let removeSquare2 = SKAction.move(to: CGPoint(x:0.0, y: self.frame.size.height), duration: TimeInterval(13.0))
        SquareMoveAndRemove2 = SKAction.sequence([moveSquare2,removeSquare2])
        
        
        let moveTriangle = SKAction.moveBy(x: -distanceToMove * darkGreyTraingleTexture.size().width, y: 0.0, duration: TimeInterval(2.0 * distanceToMove))
        let removeTriangle = SKAction.removeFromParent()
        TriangleMoveAndRemove = SKAction.sequence([moveTriangle,removeTriangle])
        
        let moveTriangle1 = SKAction.move(to: CGPoint(x: 0.0, y: self.frame.size.height), duration: TimeInterval(11))
        let removeTriangle1 = SKAction.move(to: CGPoint(x:0.0, y: self.frame.size.height - self.frame.size.height), duration: TimeInterval(11))
        TriangleMoveAndRemove1 = SKAction.sequence([moveTriangle1,removeTriangle1])
        
        let moveTriangle2 = SKAction.move(to: CGPoint(x: 0.0, y: self.frame.size.height - self.frame.size.height), duration: TimeInterval( 11))
        let removeTriangle2 = SKAction.move(to: CGPoint(x:0.0, y: self.frame.size.height), duration: TimeInterval(11))
        TriangleMoveAndRemove2 = SKAction.sequence([moveTriangle2,removeTriangle2])
        
        
        
        let scores = UserDefaults()
        //var currentScore = scores.integerForKey("Score2")
        if (score == score) {
            scores.set(score/4, forKey: "Score2")
        }
        //var showCurrentScore = scores.integerForKey("Score2")
        
        scoreLabelNode = SKLabelNode(fontNamed:"Verdana")
        scoreLabelNode.position = CGPoint( x: self.frame.midX, y: 3 * self.frame.size.height / 4 + 50 )
        scoreLabelNode.zPosition = 100
        scoreLabelNode.setScale(0.7)
        scoreLabelNode.text = String("\(score) / 16")
        self.addChild(scoreLabelNode)
        
        let L = SKLabelNode(fontNamed:"Verdana")
        L.position = CGPoint(x: self.frame.maxX - 30, y: 3 * self.frame.size.height / 4 + 50)
        L.zPosition = 100
        L.setScale(0.7)
        L.text = String("L2")
        self.addChild(L)
        
        
        let userDefaults = UserDefaults()
        let highScore = userDefaults.integer(forKey: "Highest Score")
        
        if (score / 2 > highScore) {
            userDefaults.set(score / 2, forKey: "Highest Score")
        }
        //var showHighScore = userDefaults.integerForKey("Highest Score")
        
        
        
        let placeBalls = SKAction.run({() in self.Players()})
        self.run(placeBalls)
        
        
    }
    
    
    
    enum colliderType: UInt32 {
        
        case player = 1
        case shape = 2
        case bar = 3
        case score = 4
        
    }
    
    
    func spawnTriangle() {
        
        let shapeGap = self.frame.size.height / 3
        
        let trianglePair = SKNode()
        trianglePair.position = CGPoint(x: self.frame.size.width + darkGreyTraingleTexture.size().width * 2, y: 0)
        trianglePair.zPosition = -10
        
        let height = UInt32(self.frame.size.height / 3.5)
        let y = arc4random_uniform(height) + (height / 2)
        
        let triangleUp = SKSpriteNode(texture: darkGreyTraingleTexture)
        triangleUp.setScale(self.frame.size.height / 2400)
        triangleUp.position = CGPoint(x: 0.0, y: CGFloat(y))
        
        triangleUp.physicsBody = SKPhysicsBody(texture: lightGreyTriangleTexture, size: triangleUp.size)
        triangleUp.physicsBody!.isDynamic = false
        triangleUp.physicsBody!.categoryBitMask = colliderType.shape.rawValue
        triangleUp.physicsBody!.contactTestBitMask = colliderType.player.rawValue
        triangleUp.physicsBody!.collisionBitMask = colliderType.player.rawValue
        
        trianglePair.addChild(triangleUp)
        
        let triangleDown = SKSpriteNode(texture: lightGreyTriangleTexture)
        triangleDown.setScale(self.frame.size.height / 2400)
        triangleDown.position = CGPoint(x: 0.0, y: CGFloat(y) + triangleDown.frame.size.height + CGFloat(shapeGap))
        
        triangleDown.physicsBody = SKPhysicsBody(texture: darkGreyTraingleTexture, size: triangleDown.size)
        triangleDown.physicsBody!.isDynamic = false
        triangleDown.physicsBody!.categoryBitMask = colliderType.shape.rawValue
        triangleDown.physicsBody!.contactTestBitMask = colliderType.player.rawValue
        triangleDown.physicsBody!.collisionBitMask = colliderType.player.rawValue
        trianglePair.addChild(triangleDown)
        
        let contactNode3 = SKNode()
        contactNode3.position = CGPoint( x: triangleDown.size.width + blackBall.size.width / 2, y: self.frame.minY )
        contactNode3.physicsBody = SKPhysicsBody(rectangleOf: CGSize( width: triangleUp.size.width, height: self.frame.size.height))
        contactNode3.physicsBody?.isDynamic = false
        contactNode3.physicsBody?.categoryBitMask = colliderType.score.rawValue
        contactNode3.physicsBody?.contactTestBitMask = colliderType.player.rawValue
        trianglePair.addChild(contactNode3)
        
        trianglePair.run(TriangleMoveAndRemove)
        triangleUp.run(TriangleMoveAndRemove1)
        triangleDown.run(TriangleMoveAndRemove2)
        shapes.addChild(trianglePair)
        
        
        
    }
    
    func spawnSquare() {
        
        let shapeGap = self.frame.size.height / 3
        
        let squarePair = SKNode()
        squarePair.position = CGPoint(x: self.frame.size.width + darkGreySquareTexture.size().width * 2, y: 0)
        squarePair.zPosition = -10
        
        let height = UInt32(self.frame.size.height / 3.5)
        let y = arc4random_uniform(height) + (height / 2)
        
        let squareDown = SKSpriteNode(texture: lightGreySquareTexture)
        squareDown.setScale(self.frame.size.height / 2400)
        squareDown.position = CGPoint(x: 0.0, y: CGFloat(y) + squareDown.frame.size.height + CGFloat(shapeGap))
        
        squareDown.physicsBody = SKPhysicsBody(texture: darkGreySquareTexture, size: squareDown.size)
        squareDown.physicsBody!.isDynamic = false
        squareDown.physicsBody!.categoryBitMask = colliderType.shape.rawValue
        squareDown.physicsBody!.contactTestBitMask = colliderType.player.rawValue
        squareDown.physicsBody!.collisionBitMask = colliderType.player.rawValue
        
        squarePair.addChild(squareDown)
        
        let squareUp = SKSpriteNode(texture: darkGreySquareTexture)
        squareUp.setScale(self.frame.size.height / 2400)
        squareUp.position = CGPoint(x: 0.0, y: CGFloat(y))
        
        squareUp.physicsBody = SKPhysicsBody(texture: lightGreySquareTexture, size: squareUp.size)
        squareUp.physicsBody!.isDynamic = false
        squareUp.physicsBody!.categoryBitMask = colliderType.shape.rawValue
        squareUp.physicsBody!.contactTestBitMask = colliderType.player.rawValue
        squareUp.physicsBody!.collisionBitMask = colliderType.player.rawValue
        squarePair.addChild(squareUp)
        
        let contactNode2 = SKNode()
        contactNode2.physicsBody = SKPhysicsBody(texture: blackBallTexture, size: blackBallTexture.size())
        contactNode2.position = CGPoint( x: squareDown.size.width + blackBall.size.width / 2, y: self.frame.minY )
        contactNode2.physicsBody = SKPhysicsBody(rectangleOf: CGSize( width: squareUp.size.width, height: self.frame.size.height ))
        contactNode2.physicsBody?.isDynamic = false
        contactNode2.physicsBody?.categoryBitMask = colliderType.score.rawValue
        contactNode2.physicsBody?.contactTestBitMask = colliderType.player.rawValue
        squarePair.addChild(contactNode2)
        
        squarePair.run(SquareMoveAndRemove)
        squareUp.run(SquareMoveAndRemove1)
        squareDown.run(SquareMoveAndRemove2)
        shapes.addChild(squarePair)
        
    }
    
    func spawnCircle() {
        
        let shapeGap = self.frame.size.height / 2.7
        
        let circlePair = SKNode()
        circlePair.position = CGPoint(x: self.frame.size.width + darkGreyCircleTexture.size().width * 2, y: 0)
        circlePair.zPosition = -10
        
        let height = UInt32(self.frame.size.height / 3.5)
        let y = arc4random_uniform(height) + (height / 2)
        
        let circleDown = SKSpriteNode(texture: lightGreyCircleTexture)
        circleDown.setScale(self.frame.size.height / 2400)
        circleDown.position = CGPoint(x: 0.0, y: CGFloat(y) + circleDown.frame.size.height + CGFloat(shapeGap))
        
        circleDown.physicsBody = SKPhysicsBody(circleOfRadius: circleDown.frame.size.height / 2.2)
        circleDown.physicsBody!.isDynamic = false
        circleDown.physicsBody!.categoryBitMask = colliderType.shape.rawValue
        circleDown.physicsBody!.contactTestBitMask = colliderType.player.rawValue
        circleDown.physicsBody!.collisionBitMask = colliderType.player.rawValue
        
        circlePair.addChild(circleDown)
        
        let circleUp = SKSpriteNode(texture: darkGreyCircleTexture)
        circleUp.setScale(self.frame.size.height / 2400)
        circleUp.position = CGPoint(x: 0.0, y: CGFloat(y))
        
        circleUp.physicsBody = SKPhysicsBody(circleOfRadius: circleUp.frame.size.height / 2.2)
        circleUp.physicsBody!.isDynamic = false
        circleUp.physicsBody!.categoryBitMask = colliderType.shape.rawValue
        circleUp.physicsBody!.contactTestBitMask = colliderType.player.rawValue
        circleUp.physicsBody!.collisionBitMask = colliderType.player.rawValue
        circlePair.addChild(circleUp)
        
        let contactNode = SKNode()
        contactNode.position = CGPoint( x: circleDown.size.width + blackBall.size.width / 2, y: self.frame.minY )
        contactNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize( width: circleUp.size.width, height: self.frame.size.height ))
        contactNode.physicsBody?.isDynamic = false
        contactNode.physicsBody?.categoryBitMask = colliderType.score.rawValue
        contactNode.physicsBody?.contactTestBitMask = colliderType.player.rawValue
        circlePair.addChild(contactNode)
        
        
        circlePair.run(circleMoveAndRemove)
        shapes.addChild(circlePair)
        
    }
    
    
    func Shape() {
        
        randomShape = [1 : SKAction.run({() in self.spawnCircle()}), 2 : SKAction.run({() in self.spawnSquare()}), 3 : SKAction.run({() in self.spawnTriangle()})]
        
        randomNumberShape = Int(arc4random_uniform(3) + 1)
        
        spawnShape = randomShape[randomNumberShape]!
        
        run(spawnShape)
    }
    
    
    func Players() {
        BallPair = SKNode()
        BallPair.position = CGPoint(x: self.frame.size.width / 2 - 30, y: 0)
        BallPair.zPosition = -10
        
        let holdup = SKAction.wait(forDuration: TimeInterval(0.02))
        
        greyBall = SKSpriteNode(texture: greyBallTexture)
        greyBall.setScale(self.frame.size.height / 1163.64)
        greyBall.position = CGPoint(x: self.frame.size.width / 4.5 - (self.frame.size.width / 1.77), y: self.frame.size.height / 2 - 70)
        
        greyBall.physicsBody = SKPhysicsBody(texture: greyBallTexture, size: greyBall.size)
        greyBall.physicsBody!.isDynamic = true
        greyBall.physicsBody!.allowsRotation = false
        greyBall.physicsBody!.affectedByGravity = false
        greyBall.physicsBody!.categoryBitMask = colliderType.player.rawValue
        greyBall.physicsBody!.contactTestBitMask = colliderType.shape.rawValue | colliderType.bar.rawValue
        greyBall.physicsBody!.collisionBitMask = colliderType.shape.rawValue | colliderType.bar.rawValue
        let GravityGreyBall = SKAction.run({() in self.riseGreyBall()})
        let makeGravity = SKAction.repeatForever(SKAction.sequence([GravityGreyBall,GravityGreyBall,holdup]))
        greyBall.run(makeGravity)
        BallPair.addChild(greyBall)
        
        blackBall = SKSpriteNode(texture: blackBallTexture)
        blackBall.setScale(self.frame.size.height / 1163.64)
        blackBall.position = CGPoint(x: self.frame.size.width / 4.5 - (self.frame.size.width / 1.77), y: self.frame.size.height / 2 + 70)
        
        blackBall.physicsBody = SKPhysicsBody(texture: blackBallTexture, size: blackBall.size)
        blackBall.physicsBody!.isDynamic = true
        blackBall.physicsBody!.allowsRotation = false
        blackBall.physicsBody!.affectedByGravity = false
        blackBall.physicsBody!.categoryBitMask = colliderType.player.rawValue
        blackBall.physicsBody!.contactTestBitMask = colliderType.shape.rawValue | colliderType.bar.rawValue
        blackBall.physicsBody!.collisionBitMask = colliderType.shape.rawValue | colliderType.bar.rawValue
        let antiGravityBlackBall = SKAction.run({() in self.riseBlackBall()})
        let makeAntiGravity = SKAction.repeatForever(SKAction.sequence([antiGravityBlackBall,antiGravityBlackBall,holdup]))
        blackBall.run(makeAntiGravity)
        BallPair.addChild(blackBall)
        
        
        self.addChild(BallPair)
        
    }
    
    func riseBlackBall() {
        self.blackBall.physicsBody?.applyForce(CGVector(dx: 0.0,dy: 27.85))
    }
    func riseGreyBall() {
        self.greyBall.physicsBody?.applyForce(CGVector(dx: 0.0,dy: -27.85))
    }
    
    func DeadScreenPopUp1(){
        blackBall = SKSpriteNode(texture: blackBallTexture)
        blackBall.setScale(0.66)
        blackBall.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        self.addChild(blackBall)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        if moving.speed > 0 {
            for touch: AnyObject in touches {
                _ = touch.location(in: self)
                blackBall.physicsBody?.velocity = CGVector(dx: 0,dy: -255)
                greyBall.physicsBody?.velocity = CGVector(dx: 0,dy: 255)
                
                if moving.speed < 21 {
                    moving.speed += 0.15
                }
            }
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if moving.speed > 0 {
            if (contact.bodyA.categoryBitMask & colliderType.score.rawValue) == colliderType.score.rawValue ||  (contact.bodyB.categoryBitMask & colliderType.score.rawValue) == colliderType.score.rawValue {
                
                
                score += 1
                
                
                
                let scores = UserDefaults()
                //var currentScore = scores.integerForKey("Score2")
                if (score == score) {
                    scores.set(score / 2, forKey: "Score2")
                }
                let showCurrentScore = scores.integer(forKey: "Score2")
                
                
                scoreLabelNode.text = String(stringInterpolationSegment: showCurrentScore)
                
                scoreLabelNode.run(SKAction.sequence([SKAction.scale(to: 1.5, duration:TimeInterval(0.1)), SKAction.scale(to: 1.0, duration:TimeInterval(0.1))]))
                
                let userDefaults = UserDefaults()
                let highScore = userDefaults.integer(forKey: "Highest Score")
                
                if (score / 2 > highScore) {
                    userDefaults.set(score / 2, forKey: "Highest Score")
                }
                //var showHighScore = userDefaults.integerForKey("Highest Score")
                
                if score/2 == 16 {
                    moving.speed = 0
                    
              
                }
                
            } else {
                
                moving.speed = 0
                
                self.gameView2.gameOverFunc()
                //self.DeadScreenPopUp1()
                
                
            }
            
        }
        
    }
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        
        
        
    }
    
}
