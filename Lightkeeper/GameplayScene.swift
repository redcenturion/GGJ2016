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
            world.addChild(player)
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
//        print("Update being called")
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
