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
    
    // MARK: Lifecycle
    override func didMoveToView(view: SKView) {
        print("We are now in the gameplay scene")
       
        // Setup
        setupBackground()
    }
    
    // MARK: Setup
    private func setupBackground() {
        print("Setting up the background")
        
        // Get the hill textures
        let hill_1 = self.createSpriteFromAtlas(name: "hills1")
        hill_1.zPosition = -1
        hill_1.position = CGPointMake(0, UIScreen.mainScreen().bounds.size.height / 3)
        print("Hill_1 position = \(hill_1.position)")
        
        let hill_2 = self.createSpriteFromAtlas(name: "hills2")
        hill_2.zPosition = -2
        hill_2.position = CGPointMake(hill_1.position.x + hill_1.size.width, hill_1.position.y)
        
        // Add to the scene
        self.addChild(hill_1)
        self.addChild(hill_2)

    }
    
    // MARK: Sprites
    private func createSpriteFromAtlas(name spriteName: String) -> SKSpriteNode {
        let atlas = SKTextureAtlas(named: "sprites")
        let spriteTexture = atlas.textureNamed(spriteName)
        let spriteNode = SKSpriteNode.init(texture: spriteTexture)
        spriteNode.anchorPoint = CGPointMake(0.5,0.5)
       
        return spriteNode
    }
    
    // MARK: Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("You are touching the screen!")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Your touch has ended!")
    }
    
    override func update(currentTime: NSTimeInterval) {
//        print("Update being called")
    }
}
