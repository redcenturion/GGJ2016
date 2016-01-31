//
//  MainMenuScene.swift
//  Lightkeeper
//
//  Created by Peter Huynh on 1/30/16.
//  Copyright © 2016 GGJ2016. All rights reserved.
//

import SpriteKit
import AVFoundation

class MainMenuScene: SKScene, AVAudioPlayerDelegate {
    
    private let title: SKLabelNode = SKLabelNode.init(text: "Dawn of Day")
    private var playButton: SKNode?
    private var aboutButton: SKNode?
    private var bgmPlayer: AVAudioPlayer?
    
    override func didMoveToView(view: SKView) {
        print("We are now in main menu scene")
       
        // Background
        self.backgroundColor = UIColor.blackColor()
        
        bgmPlayer = AVAudioPlayer()
        
        // Add the UI elements of the scene
        setupUI()
        setupPlayButton()
        setupAboutButton()
        setupBackgroundEffect()
        setupBackgroundEffect1()
        
        //swipe gestures
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)

        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
    }
    
 func touchesBegin(touches: NSSet, withEvent event: UIEvent) {
        
        self.menuHelper(touches)
    }
    
    private func menuHelper(touches:NSSet) {
        for touch in touches {
            let nodeAtTouch = self.nodeAtPoint(touch.locationInNode(self))
            if nodeAtTouch.name == "Play" {
                print("Play button pressed")
            
            } else if nodeAtTouch.name == "About" {
                print("About button pressed")
            }
        }
    }
    
    // MARK: UI Elements
    private func setupUI() {
        // Set up the title
        title.zPosition = 1
        title.position = CGPointMake(UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height / 1.5)
        self.addChild(title)
    }
    private func setupBackgroundEffect() {
        let path = NSBundle.mainBundle().pathForResource("greenMagic", ofType: "sks")
        let greenMagicParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        
        greenMagicParticle.position = CGPointMake(self.size.width/2, self.size.height/2)
        greenMagicParticle.name = "greenMagicParticle"
        greenMagicParticle.targetNode = self.scene
        
        self.addChild(greenMagicParticle)
    }
    private func setupBackgroundEffect1() {
        let path = NSBundle.mainBundle().pathForResource("Fire", ofType: "sks")
        let FireParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        
        FireParticle.position = CGPointMake(self.size.width/2, self.size.height/1.8)
        FireParticle.name = "FireParticle"
        FireParticle.targetNode = self.scene
        
        self.addChild(FireParticle)
        self.playBGM("Music_Main_Theme")
    }
    private func setupPlayButton() {
        print("Setting up the play button")
        
        // Create title label
        let titleLabel: SKLabelNode = SKLabelNode()
        titleLabel.text = "Swipe Right to Play"
        titleLabel.fontColor = SKColor.blackColor()
        titleLabel.name = "Play"
        
        titleLabel.zPosition = 5
        playButton = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 300, height: 44))
        // Put it in the center of the scene
        if let playButton = playButton {
            playButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
            playButton.zPosition = 4
            playButton.addChild(titleLabel)
            self.addChild(playButton)
        } else { print("something went wrong!") }
        
    }
    
    private func setupAboutButton() {
        print("Setting up the play button")
        
        // Create title label
        let titleLabel: SKLabelNode = SKLabelNode()
        titleLabel.text = "Swipe left for About"
        titleLabel.fontColor = SKColor.blackColor()
        
        titleLabel.zPosition = 5
        aboutButton = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 300, height: 44))
        // Put it in the center of the scene
        if let aboutButton = aboutButton, playButton = playButton {
            aboutButton.position = CGPoint(x: playButton.position.x, y: playButton.position.y - 70);
            aboutButton.zPosition = 4
            aboutButton.addChild(titleLabel)
            self.addChild(aboutButton)
        } else { print("something went wrong!") }
        
            }
    // Swipe right to enter gameplay scene
    func swipedRight(sender:UISwipeGestureRecognizer) {
        
        let gameSceneTemp = InstructionsScene(size: self.size)
        gameSceneTemp.scaleMode = scaleMode
        let reveal = SKTransition.fadeWithDuration(1)
        self.view?.presentScene(gameSceneTemp, transition: reveal)
        
        
        print("swiped right")
        
    }
    //Swipe left to enter about
    func swipedLeft(sender:UISwipeGestureRecognizer) {
        
        let gameSceneTemp = AboutScene(size: self.size)
        gameSceneTemp.scaleMode = scaleMode
        let reveal = SKTransition.fadeWithDuration(1)
        self.view?.presentScene(gameSceneTemp, transition: reveal)
        
        
        print("swiped left")
        
    }
    
    private func playBGM(soundName: String) {
        let path = NSBundle.mainBundle().pathForResource(soundName, ofType: "m4a")
        if let path = path {
            do {
                let nsurl = NSURL(fileURLWithPath: path)
                bgmPlayer = try AVAudioPlayer(contentsOfURL:nsurl)
                if let audioPlayer = bgmPlayer {
                    audioPlayer.prepareToPlay()
                    audioPlayer.delegate = self
                    audioPlayer.numberOfLoops = -1
                    audioPlayer.volume = 0.8
                    audioPlayer.play()
                }
            } catch { print("Error getting the audio file") }
        } else { print("Not playing anything!") }
    }
}
