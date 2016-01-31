//
//  MainMenuViewController.swift
//  Lightkeeper
//
//  Created by Peter Huynh on 1/30/16.
//  Copyright © 2016 GGJ2016. All rights reserved.
//

import UIKit
import SpriteKit


class MainMenuViewController: UIViewController {
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            print("MainMenuView is loading")
            
            let scene: SKScene = MainMenuScene(size: view.bounds.size)
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .ResizeFill
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