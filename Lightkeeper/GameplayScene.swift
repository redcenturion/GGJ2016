//
//  GameplayScene.swift
//  Lightkeeper
//
//  Created by Steven Yang on 1/30/16.
//  Copyright © 2016 GGJ2016. All rights reserved.
//

import Foundation
import SpriteKit

class GameplayScene: SKScene {
    
    // MARK: Variables
    private let world: SKNode = SKNode()
    private var player: SKSpriteNode?
   
    // Constants
    private let MIDSCREEN: CGPoint = CGPointMake(UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height / 2)
    private let PLAYER_SPEED: CGFloat = 3.0
   
    // Movement
    private var touchPosition: CGPoint = CGPointZero
    private var distanceToMove: CGFloat = 0
    private var fingerOnScreenTime: Double = 0
    private var playerShouldMove: Bool = false
    
    // MARK: Lifecycle
    override func didMoveToView(view: SKView) {
        print("We are now in the gameplay scene")
       
        // Setup
        setupWorld()
        setupBackground()
        setupPlayer()
    }
    
    // MARK: Setup
    private func setupWorld() {
        self.addChild(world)
    }
    private func setupBackground() {
        print("Setting up the background")
        
        self.backgroundColor = SKColor.grayColor()
        
        // Get the hill textures
        let hill_1 = self.createSpriteFromAtlas(name: "hills1")
        hill_1.zPosition = -1
        hill_1.position = CGPointMake(0, UIScreen.mainScreen().bounds.size.height / 3)
        print("Hill_1 position = \(hill_1.position)")
        
        let hill_2 = self.createSpriteFromAtlas(name: "hills2")
        hill_2.zPosition = -2
        hill_2.position = CGPointMake(hill_1.position.x + hill_1.size.width, hill_1.position.y)
        
        // Add to the scene
        world.addChild(hill_1)
        world.addChild(hill_2)
        
        let cyanOrb: SKShapeNode = self.createOrbWithColorValues(r: 0, g: 255, b: 255)
        cyanOrb.position = CGPointMake(100, 200)
        cyanOrb.name = "CyanOrb"
        world.addChild(cyanOrb)
        
        let redOrb: SKShapeNode = self.createOrbWithColorValues(r: 255, g: 0, b: 0)
        redOrb.position = CGPointMake(150, 200)
        redOrb.name = "RedOrb"
        world.addChild(redOrb)
        
        let blackOrb: SKShapeNode = self.createOrbWithColorValues(r: 0, g: 0 , b: 0)
        blackOrb.position = CGPointMake(200, 200)
        blackOrb.name = "BlackOrb"
        world.addChild(blackOrb)
        
        let yellowOrb: SKShapeNode = self.createOrbWithColorValues(r: 255, g: 255, b: 0)
        yellowOrb.position = CGPointMake(250, 200)
        yellowOrb.name = "YellowOrb"
        world.addChild(yellowOrb)
        
        let greenOrb: SKShapeNode = self.createOrbWithColorValues(r: 0, g: 255, b: 0)
        greenOrb.position = CGPointMake(300, 200)
        greenOrb.name = "GreenOrb"
        world.addChild(greenOrb)
        
        let blueOrb: SKShapeNode = self.createOrbWithColorValues(r: 0, g: 0, b: 255)
        blueOrb.position = CGPointMake(350, 200)
        blueOrb.name = "BlueOrb"
        world.addChild(blueOrb)
        
        let purpleOrb: SKShapeNode = self.createOrbWithColorValues(r: 255, g: 0, b: 255)
        purpleOrb.position = CGPointMake(400, 200)
        purpleOrb.name = "PurpleOrb"
        world.addChild(purpleOrb)
        
        let whiteOrb: SKShapeNode = self.createOrbWithColorValues(r: 255, g: 255, b: 255)
        whiteOrb.position = CGPointMake(450, 200)
        whiteOrb.name = "WhiteOrb"
        world.addChild(whiteOrb)
    }
    
    private func setupPlayer() {
        player = self.createSpriteFromAtlas(name: "player")
        if let player = player {
        print("Player being loaded")
            player.anchorPoint = CGPointMake(0.5, 0.5)
            player.position = CGPointMake(MIDSCREEN.x, MIDSCREEN.y - 100)
            player.setScale(0.4)
            player.zPosition = 10
            print("Player position is \(player.position)")
            self.addChild(player)
        } else { print("Player not loaded") }
    }
    
    // MARK: Sprites
    private func createSpriteFromAtlas(name spriteName: String) -> SKSpriteNode {
        let atlas = SKTextureAtlas(named: "sprites")
        let spriteTexture = atlas.textureNamed(spriteName)
        let spriteNode = SKSpriteNode.init(texture: spriteTexture)
        spriteNode.anchorPoint = CGPointMake(0.5,0.5)
       
        return spriteNode
    }
    
    private func createOrbWithColorValues(r red: CGFloat, g green: CGFloat, b blue: CGFloat, a alpha: CGFloat = 1) -> SKShapeNode {
        let orb = SKShapeNode(circleOfRadius: 30)
        orb.fillColor = SKColor(red: red, green: green, blue: blue, alpha: alpha)
        orb.strokeColor = SKColor(red: red, green: green, blue: blue, alpha: alpha)
        orb.glowWidth = 10.0
        
        return orb
    }
    
    // MARK: Player
    private func movePlayerToTouchPosition(location touch: CGPoint) {
        guard let player = player else { return }
        distanceToMove = touch.x - player.position.x
        print("Move distance = \(distanceToMove)")
        
    }
    
    // MARK: Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        print("You are touching the screen!")
        touchPosition = touch.locationInNode(self)
        print("The touch position is \(touchPosition)")
        playerShouldMove = true
        movePlayerToTouchPosition(location: touchPosition)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        print("Your touch has ended!")
        playerShouldMove = false
        fingerOnScreenTime = 0
    }
    
    override func update(currentTime: NSTimeInterval) {
        guard let player = player else { return }
       
        // Ensure only run when player has finger on screen
        if playerShouldMove {
            fingerOnScreenTime += 0.1
        } else { return }
        
        if abs(distanceToMove) < 0.2 { return }
       
        if distanceToMove >= 0 {
            distanceToMove -= CGFloat(fingerOnScreenTime)
            player.position = CGPointMake(player.position.x + CGFloat(fingerOnScreenTime), player.position.y)
        } else if  distanceToMove < 0 {
            distanceToMove += CGFloat(fingerOnScreenTime)
            player.position = CGPointMake(player.position.x - CGFloat(fingerOnScreenTime), player.position.y)
        }
    }
}
