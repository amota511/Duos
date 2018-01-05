//
//  GameViewController.swift
//  Duos V2
//
//  Created by amota511 on 8/16/15.
//  Copyright (c) 2015 Aaron Motayne. All rights reserved.
//


import UIKit
import SpriteKit
import AVFoundation
import iAd
import GameKit

extension SKNode {
    class func unarchiveFromFile(_ file : String) -> SKNode? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks") {
            let sceneData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
    class func unarchiveFromFile1(_ file : String) -> SKNode? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks") {
            let sceneData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! levelOne
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
    class func unarchiveFromFile2(_ file : String) -> SKNode? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks") {
            let sceneData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! levelTwo
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
    class func unarchiveFromFile3(_ file : String) -> SKNode? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks") {
            let sceneData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! levelThree
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
    class func unarchiveFromFile4(_ file : String) -> SKNode? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks") {
            let sceneData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! GameOver
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
    
    class func unarchiveFromFile5(_ file : String) -> SKNode? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks") {
            let sceneData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! levelEndless
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
    

/*
class func unarchiveFromFile6(file : String) -> SKNode? {
    if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
        let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
        let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
        
        archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
        let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! Tutorial
        archiver.finishDecoding()
        return scene
    } else {
        return nil
    }
}*/

}
class GameViewController: UIViewController,ADInterstitialAdDelegate, GKGameCenterControllerDelegate {
    
    var startAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "Game Music FINAL", ofType: "mp3")!)
    var playAudio : AVAudioPlayer!
    var NumberLevel = 0
    var musicTime: TimeInterval!
    
    
    var interAd = ADInterstitialAd()
    var interAdView: UIView = UIView()
    var closeButton = UIButton(type: UIButtonType.system)
    var adLoaded = Bool()
    var died = 0
    
    
    var gcEnabled = Bool()
    var gcDefaultLeaderBoard = String()
    var score = UserDefaults().integer(forKey: "Highest Score")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameStartFunc()
        
        self.authenticateLocalPlayer()
        
        
        closeButton.frame = CGRect(x: 10, y: 5, width: 50, height: 50)
        closeButton.layer.cornerRadius = 10
        closeButton.setTitle("x", for: UIControlState())
        closeButton.setTitleColor(UIColor.black, for: UIControlState())
        closeButton.backgroundColor = UIColor.white
        closeButton.layer.borderColor = UIColor.black.cgColor
        closeButton.layer.borderWidth = 1
        closeButton.addTarget(self, action: #selector(GameViewController.close(_:)), for: UIControlEvents.touchDown)
        
        // Preload a new iAd
        print("load ad")
        interAd = ADInterstitialAd()
        interAd.delegate = self
        
        playAudio = try? AVAudioPlayer(contentsOf: startAudio)
        playAudio.numberOfLoops = 2015
        playAudio.play()
        
        
    }
    
    func close(_ sender: UIButton) {
        closeButton.removeFromSuperview()
        interAdView.removeFromSuperview()
        interAd.delegate = nil
        
        // Preload a new iAd
        print("load ad")
        interAd = ADInterstitialAd()
        interAd.delegate = self
        
        adLoaded = false
    }
    
    
    @IBAction func showAd() {
        if(adLoaded == true) { // If ad hasn't loaded show nothing, otherwise load the ad
            loadAd()
        }
    }
    
    func submitScore(){
        
    let leaderBoardID = "DuosLeaderBoard"
    let sscore = GKScore(leaderboardIdentifier: leaderBoardID)
    
        sscore.value = Int64(score)
        
        //let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        GKScore.report([sscore], withCompletionHandler: {  (error: Error?) -> Void in
            if error != nil{
                print("Score Submitted")
            } else{
                print(error!.localizedDescription)
            }
        })
        
        
    }
    
    
    func showLeaderBoard(){
        
        let gcVC:GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = GKGameCenterViewControllerState.leaderboards
        gcVC.leaderboardIdentifier = "DuosLeaderBoard"
        self.present(gcVC, animated: true, completion: nil)
        
        
        
        
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    
    func authenticateLocalPlayer(){
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                self.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                print("Local Player already authenticated")
                self.gcEnabled = true
                print("Local Player Already authenticated")
                
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: {  (leaderboardIdentifier: String?, error: Error?) -> Void in
                    if error != nil {
                        print(error)
                    } else{
                        self.gcDefaultLeaderBoard = leaderboardIdentifier!
                    }
                })
                
                
            } else{
                self.gcEnabled = false
                print("Local player cold not be authenticatd, disabling game center")
                print(error)
            }
        
        }
    }
    
    func loadAd() {
        // Show the preloaded iAd
        view.addSubview(interAdView)
        
        interAd.present(in: interAdView)
        UIViewController.prepareInterstitialAds()
        
        interAdView.addSubview(closeButton)
    }
    
    
    func interstitialAdDidLoad(_ interstitialAd: ADInterstitialAd!) {
        print("ad did load")
        
        interAdView = UIView()
        interAdView.frame = self.view.bounds
        adLoaded = true
        
    }
    
    
    func interstitialAdDidUnload(_ interstitialAd: ADInterstitialAd!) {
        
    }
    
    func interstitialAd(_ interstitialAd: ADInterstitialAd!, didFailWithError error: Error!) {
        print("failed to receive")
        print(error.localizedDescription)
        
        closeButton.removeFromSuperview()
        interAdView.removeFromSuperview()
        
    }
    
    func GameStartFunc(){
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
            scene.gameView0 = self
        }
        
        
    }
    
    
    func levelOneFunc(){
        
        
        if let scene = levelOne.unarchiveFromFile1("GameScene") as? levelOne {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
            scene.gameView1 = self
            
        }

       
        
    }
    
    func levelTwoFunc(){
        
        
        if let scene = levelTwo.unarchiveFromFile2("GameScene") as? levelTwo {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
            scene.gameView2 = self
            
        }
        
        
        
    }
    
    func levelThreeFunc(){
        
        
        if let scene = levelThree.unarchiveFromFile3("GameScene") as? levelThree {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
            scene.gameView3 = self
            
        }
        
        
        
    }
    
    func gameOverFunc(){
        
        
        if let scene = GameOver.unarchiveFromFile4("GameScene") as? GameOver {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
            scene.gameView4 = self
            
        }
        
        died = died + 1
        if died == 5 {
         showAd()
            died = 0
        }
        
        
    }
    
    func levelEndlessFunc(){
        
        
        if let scene = levelEndless.unarchiveFromFile5("GameScene") as? levelEndless {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
            scene.gameView5 = self
            
        }
        
        
        
    }
    
    func TutorialFunc(){
        /*
        
        if let scene = Tutorial.unarchiveFromFile5("GameScene") as? Tutorial {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = !false
            skView.showsNodeCount = !false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
            scene.gameView6 = self
            
        }
        
        */
        
    }
    
    func musicControlFunction(){
        if playAudio.isPlaying == true{
            musicTime = playAudio.currentTime
           playAudio.stop()
        }else{
            playAudio.play()
        }
        
    }
    
    func DeadScreenPopUp(){
        
        var deadFrame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200)
        deadFrame.size = CGSize(width: 100,height: 100)
        let deadView: UIView = UIView(frame: deadFrame)
        deadView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        deadView.alpha = 0.5
        
        self.view?.addSubview(deadView)
        
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.allButUpsideDown
        } else {
            return UIInterfaceOrientationMask.all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
