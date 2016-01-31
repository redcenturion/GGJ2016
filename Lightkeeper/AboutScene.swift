//
//  About.swift
//  Lightkeeper
//
//  Created by Peter Huynh on 1/31/16.
//  Copyright © 2016 GGJ2016. All rights reserved.
//

import Foundation

import SpriteKit

class AboutScene: SKScene {
    
    
    private var playButton: SKNode?
    private var aboutButton: SKNode?
    
    override func didMoveToView(view: SKView) {
        print("We are now in main menu scene")
        
        // Background
        self.backgroundColor = UIColor.blackColor()
        
        // Add the UI elements of the scene
        
        setupPlayButton()
        setupAboutButton()
        setupBackgroundEffect()
        setupBackgroundEffect1()
        
        //swipe gestures
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
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
    }
    private func setupPlayButton() {
        print("Setting up the play button")
        
        // Create title label
        let titleLabel: SKLabelNode = SKLabelNode()
        titleLabel.text = "The lands are overwhelmed in darkness but"
        titleLabel.fontColor = SKColor.whiteColor()
        titleLabel.name = "Play"
        titleLabel.position = CGPointMake(0,160)
        
        
        let titleLabel1: SKLabelNode = SKLabelNode()
        titleLabel1.text = "performing a Dawn of Day ritual will awaken the great sun."
        titleLabel1.fontColor = SKColor.whiteColor()
        titleLabel1.name = "Play1"
        titleLabel1.position = CGPointMake(0,120)
        
        let titleLabel2: SKLabelNode = SKLabelNode()
        titleLabel2.text = "As the Lightkeeper you must complete the ritual by"
        titleLabel2.fontColor = SKColor.whiteColor()
        titleLabel2.name = "Play2"
        titleLabel2.position = CGPointMake(0,80)
        
        let titleLabel3: SKLabelNode = SKLabelNode()
        titleLabel3.text = "collecting orbs of light in the order that they appear."
        titleLabel3.fontColor = SKColor.whiteColor()
        titleLabel3.name = "Play3"
        titleLabel3.position = CGPointMake(0,40)
        
        let titleLabel4: SKLabelNode = SKLabelNode()
        titleLabel4.text = "If you successfully collect the orbs you will be rewarded"
        titleLabel4.fontColor = SKColor.whiteColor()
        titleLabel4.name = "Play4"
        titleLabel4.position = CGPointMake(0,0)
        
        let titleLabel5: SKLabelNode = SKLabelNode()
        titleLabel5.text = "with the warmth and light of the sun. Good luck!"
        titleLabel5.fontColor = SKColor.whiteColor()
        titleLabel5.name = "Play5"
        titleLabel5.position = CGPointMake(0,-40)
        
        
        
        titleLabel.zPosition = 5
        titleLabel1.zPosition = 5
        playButton = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 0, height: 0))
        // Put it in the center of the scene
        if let playButton = playButton {
            playButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
            playButton.zPosition = 4
            playButton.addChild(titleLabel)
            playButton.addChild(titleLabel1)
            playButton.addChild(titleLabel2)
            playButton.addChild(titleLabel3)
            playButton.addChild(titleLabel4)
            playButton.addChild(titleLabel5)
            
            self.addChild(playButton)
        } else { print("something went wrong!") }
        
    }
   
    
    private func setupAboutButton() {
        print("Setting up the play button")
        
        // Create title label
        let titleLabel: SKLabelNode = SKLabelNode()
        titleLabel.text = "Swipe right to return to main menu"
        titleLabel.fontColor = SKColor.whiteColor()
        
        titleLabel.zPosition = 5
        aboutButton = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 0, height: 0))
        // Put it in the center of the scene
        if let aboutButton = aboutButton, playButton = playButton {
            aboutButton.position = CGPoint(x: playButton.position.x, y: playButton.position.y - 140);
            aboutButton.zPosition = 4
            aboutButton.addChild(titleLabel)
            self.addChild(aboutButton)
        } else { print("something went wrong!") }
        
    }
        
    // Swipe right to enter gameplay scene
    func swipedRight(sender:UISwipeGestureRecognizer) {
        
        let gameSceneTemp = MainMenuScene(size: self.size)
        gameSceneTemp.scaleMode = scaleMode
        let reveal = SKTransition.fadeWithDuration(1)
        self.view?.presentScene(gameSceneTemp, transition: reveal)
        
        
        print("swiped right")
        
    }

    
}
