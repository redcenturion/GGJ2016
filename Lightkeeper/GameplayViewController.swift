//
//  GameplayViewController.swift
//  Lightkeeper
//
//  Created by Steven Yang on 1/30/16.
//  Copyright © 2016 GGJ2016. All rights reserved.
//

import UIKit
import SpriteKit

class GameplayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("GameplayView is loading")
        
        let scene: SKScene? = GameplayScene()
        
        // Setting up the SKView
//        let skview = SKView.init(frame: UIScreen.mainScreen().bounds)
        
        let skView = SKView.init()
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        if let scene = scene {
            scene.scaleMode = .AspectFill
        }
        
        skView.presentScene(scene)
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
