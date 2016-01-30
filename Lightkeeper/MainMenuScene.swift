//
//  MainMenuScene.swift
//  Lightkeeper
//
//  Created by Peter Huynh on 1/30/16.
//  Copyright © 2016 GGJ2016. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    var playButton = SKSpriteNode()
    let playButtonText = SKTexture(imageNamed: "play")
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        print("We are now in main menu scene")
    }
    
    
    
}
