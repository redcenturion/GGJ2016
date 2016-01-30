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
        super.didMoveToView(view)
        print("We are now in the gameplay scene")
       
        // Setup
        setupBackground()
    }
    
    // MARK: Setup
    private func setupBackground() {
        print("Setting up the background")
        
        // Get the hill textures
        let atlas = SKTextureAtlas(named: "sprites")
        let hill_1 = atlas.textureNamed("hills1")
        let hill_1_Node = SKSpriteNode.init(texture: hill_1)
        hill_1_Node.zPosition = -1
        hill_1_Node.anchorPoint = CGPointMake(0.5,0.5)
        
        // Add to the scene
        self.addChild(hill_1_Node)
    }
    
    // MARK: Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("You are touching the screen!")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Your touch has ended!")
    }
    
    override func update(currentTime: NSTimeInterval) {
        print("Update being called")
    }
}
