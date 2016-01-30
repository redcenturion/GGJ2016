//
//  MainMenuScene.swift
//  Lightkeeper
//
//  Created by Peter Huynh on 1/30/16.
//  Copyright © 2016 GGJ2016. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    private let title: SKLabelNode = SKLabelNode.init(text: "Lightkeeper")
    private var playButton: SKNode?
    private var aboutButton: SKNode?
    
    override func didMoveToView(view: SKView) {
        print("We are now in main menu scene")
       
        // Background
        self.backgroundColor = UIColor.grayColor()
        
        // Add the UI elements of the scene
        setupUI()
        setupPlayButton()
        setupAboutButton()
    }
    
    // MARK: UI Elements
    private func setupUI() {
        // Set up the title
        title.zPosition = 1
        title.position = CGPointMake(UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height / 1.5)
        self.addChild(title)
    }
    
    private func setupPlayButton() {
        print("Setting up the play button")
        
        // Create title label
        let titleLabel: SKLabelNode = SKLabelNode()
        titleLabel.text = "Play"
        titleLabel.fontColor = SKColor.blackColor()
        
        titleLabel.zPosition = 5
        playButton = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 100, height: 44))
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
        titleLabel.text = "About"
        titleLabel.fontColor = SKColor.blackColor()
        
        titleLabel.zPosition = 5
        aboutButton = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 100, height: 44))
        // Put it in the center of the scene
        if let aboutButton = aboutButton, playButton = playButton {
            aboutButton.position = CGPoint(x: playButton.position.x, y: playButton.position.y - 70);
            aboutButton.zPosition = 4
            aboutButton.addChild(titleLabel)
            self.addChild(aboutButton)
        } else { print("something went wrong!") }
    }
}
