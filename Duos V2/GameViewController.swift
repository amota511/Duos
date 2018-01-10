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

class GameViewController: UIViewController, NumberOfGamesPlayedDelegate, GADInterstitialDelegate {
    
    var interstitial: GADInterstitial!
    
    var startAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "Game Music FINAL", ofType: "mp3")!)
    var playAudio : AVAudioPlayer!
    var NumberLevel = 0
    var musicTime: TimeInterval!
    
    var numOfGamesPlayed = 0
    
    var died = 0
    
    var scene: GameScene? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAd()
        createScene()
        playBackgroundMusic()
        
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        scene?.shouldRewind = true
    }
    
    func loadAd() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        
        let request = GADRequest()
        interstitial.load(request)
    }
    
    
    func showAd() {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            scene?.shouldRewind = true
        }
    }
    
    func createScene() {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = loadGameScene() as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                // Present the scene
                view.presentScene(scene)
                scene.parentViewController = self
                self.scene = scene
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
    
    func gameOver(){

        if numOfGamesPlayed == 3 {
            showAd()
            loadAd()
            numOfGamesPlayed = 0
        } else {
            scene?.shouldRewind = true
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
