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
import GameKit

import GoogleMobileAds

protocol NumberOfGamesPlayedDelegate {
    var numOfGamesPlayed: Int {get set}
}

class GameViewController: UIViewController, NumberOfGamesPlayedDelegate {
    
    var interstitial: GADInterstitial!
    
    var startAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "Game Music FINAL", ofType: "mp3")!)
    var playAudio : AVAudioPlayer!
    var NumberLevel = 0
    var musicTime: TimeInterval!
    
    var numOfGamesPlayed = 0
    
    var died = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAd()
        createScene()
        playBackgroundMusic()
        
    }
    
    func loadAd() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        
        print("load ad")
        let request = GADRequest()
        interstitial.load(request)
    }
    
    
    func showAd() {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    func createScene() {
        print("create scene")

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = loadGameScene() as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                print("should be working")
                
                // Present the scene
                view.presentScene(scene)
                scene.parentViewController = self
            }
            view.ignoresSiblingOrder = true
        }
    }
    
    func loadGameScene() -> SKNode? {

        if let path = Bundle.main.path(forResource: "GameScene", ofType: "sks") {
            let sceneData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            archiver.setClass(GameScene.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
        
    }
    
    func playBackgroundMusic() {
        
        playAudio = try? AVAudioPlayer(contentsOf: startAudio)
        playAudio.numberOfLoops = Int.max
        playAudio.play()
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
            
            //scene.scaleMode = .resizeFill
//            scene.frame = skView.frame
            
            skView.presentScene(scene)
            
            scene.parentViewController = self
        }
    }
    
    
    func gameOverFunc(){
        
//        died += 1
//        if died == 2 {
//            showAd()
//            loadAd()
//            died = 0
//        }
        if numOfGamesPlayed == 2{
            showAd()
            loadAd()
            numOfGamesPlayed = 0
        }
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
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

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
}
