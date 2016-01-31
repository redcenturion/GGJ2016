//
//  InstructionsScene.swift
//  Lightkeeper
//
//  Created by Steven Yang on 1/30/16.
//  Copyright © 2016 GGJ2016. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class InstructionsScene: SKScene, AVAudioPlayerDelegate {
    
    // MARK: Variables
    private let world: SKNode = SKNode()
    private var orbPlayer_Cyan: AVAudioPlayer?
    private var orbPlayer_Red: AVAudioPlayer?
    private var orbPlayer_Black: AVAudioPlayer?
    private var orbPlayer_Yellow: AVAudioPlayer?
    private var orbPlayer_Green: AVAudioPlayer?
    private var orbPlayer_Blue: AVAudioPlayer?
    private var orbPlayer_Purple: AVAudioPlayer?
    private var orbPlayer_White: AVAudioPlayer?
    
    // Orbs
    private var cyanOrb: SKShapeNode?
    private var redOrb: SKShapeNode?
    private var blackOrb: SKShapeNode?
    private var yellowOrb: SKShapeNode?
    private var greenOrb: SKShapeNode?
    private var blueOrb: SKShapeNode?
    private var purpleOrb: SKShapeNode?
    private var whiteOrb: SKShapeNode?
    
    // Constants
    private let MIDSCREEN: CGPoint = CGPointMake(UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height / 2)
    private let ORB_RADIUS: CGFloat = 30
    
    // MARK: Lifecycle
    override func didMoveToView(view: SKView) {
        print("We are now in the instructions scene")
        
        // Set up AVPlayers
        orbPlayer_Cyan = AVAudioPlayer()
        orbPlayer_Red = AVAudioPlayer()
        orbPlayer_Black = AVAudioPlayer()
        orbPlayer_Yellow = AVAudioPlayer()
        orbPlayer_Green = AVAudioPlayer()
        orbPlayer_Blue = AVAudioPlayer()
        orbPlayer_Purple = AVAudioPlayer()
        orbPlayer_White = AVAudioPlayer()
        
        // Setup
        setupWorld()
        setupOrbs()
        setupBackground()
        playOrbInRandomOrder()
    }
    
    // MARK: Setup
    private func setupWorld() {
        self.addChild(world)
    }
    private func setupBackground() {
        print("Setting up the background")
        self.backgroundColor = SKColor.grayColor()
    }
    
    private func setupOrbs() {
        cyanOrb = self.createOrbWithColorValues(r: 0, g: 255, b: 255)
        if let cyanOrb = cyanOrb {
            cyanOrb.position = CGPointMake(MIDSCREEN.x - 0, MIDSCREEN.y - 0)
            cyanOrb.name = "CyanOrb"
            print("Cyan Orb frame: \(cyanOrb.frame)")
            world.addChild(cyanOrb)
        }
        
        redOrb = self.createOrbWithColorValues(r: 255, g: 0, b: 0)
        if let redOrb = redOrb {
            redOrb.position = CGPointMake(150, 200)
            print("Red Orb frame: \(redOrb.frame)")
            redOrb.name = "RedOrb"
            world.addChild(redOrb)
        }
        
        blackOrb = self.createOrbWithColorValues(r: 0, g: 0 , b: 0)
        if let blackOrb = blackOrb {
            blackOrb.position = CGPointMake(200, 200)
            blackOrb.name = "BlackOrb"
            world.addChild(blackOrb)
        }
        
        yellowOrb = self.createOrbWithColorValues(r: 255, g: 255, b: 0)
        if let yellowOrb = yellowOrb {
            yellowOrb.position = CGPointMake(250, 200)
            yellowOrb.name = "YellowOrb"
            world.addChild(yellowOrb)
        }
        
        greenOrb = self.createOrbWithColorValues(r: 0, g: 255, b: 0)
        if let greenOrb = greenOrb {
            greenOrb.position = CGPointMake(300, 200)
            greenOrb.name = "GreenOrb"
            //        greenOrb.runAction(SKAction.scaleBy(5, duration: 2.0))
            world.addChild(greenOrb)
        }
        
        blueOrb = self.createOrbWithColorValues(r: 0, g: 0, b: 255)
        if let blueOrb = blueOrb {
            blueOrb.position = CGPointMake(350, 200)
            blueOrb.name = "BlueOrb"
            world.addChild(blueOrb)
        }
        
        purpleOrb = self.createOrbWithColorValues(r: 255, g: 0, b: 255)
        if let purpleOrb = purpleOrb {
            purpleOrb.position = CGPointMake(400, 200)
            purpleOrb.name = "PurpleOrb"
            world.addChild(purpleOrb)
        }
        
        whiteOrb = self.createOrbWithColorValues(r: 255, g: 255, b: 255)
        if let whiteOrb = whiteOrb {
            whiteOrb.position = CGPointMake(450, 200)
            whiteOrb.name = "WhiteOrb"
            world.addChild(whiteOrb)
        }
    }
    
    // MARK: Orb
    private func createOrbWithColorValues(r red: CGFloat, g green: CGFloat, b blue: CGFloat, a alpha: CGFloat = 1) -> SKShapeNode {
        let orb = SKShapeNode(circleOfRadius: ORB_RADIUS)
        orb.fillColor = SKColor(red: red, green: green, blue: blue, alpha: alpha)
        orb.strokeColor = SKColor(red: red, green: green, blue: blue, alpha: alpha)
        orb.glowWidth = 10.0
        
        return orb
    }
    
    private func createOrbTouchRectBasedOffOrbPosition(position: CGPoint) -> CGRect {
        let rect = CGRectMake(position.x, position.y, ORB_RADIUS, ORB_RADIUS)
        return rect
    }
   
    private func playOrbInRandomOrder() {
        let array = NSMutableArray()
        for element in 1...8 {
            array.addObject(element)
        }
        let count = array.count - 1
        for element in 0...count {
            let remainingCount:Int = count - element
            let exchangeIndex: Int = element + Int(arc4random_uniform(UInt32(remainingCount)))
            array.exchangeObjectAtIndex(count, withObjectAtIndex: exchangeIndex)
        }
        
        for element in array {
            switch element.intValue {
            case 0:
                if let cyanOrb = cyanOrb {
                    cyanOrb.runAction(SKAction.scaleTo(5, duration: 1.0))
                    self.playSound("SXF_Orb_1", color: "Cyan")
                }
                break
            case 1:
                if let redOrb = redOrb {
                    redOrb.runAction(SKAction.scaleTo(5, duration: 1.0))
                    self.playSound("SXF_Orb_2", color: "Red")
                }
                break
            case 2:
                if let blackOrb = blackOrb {
                    blackOrb.runAction(SKAction.scaleTo(5, duration: 1.0))
                    self.playSound("SXF_Orb_3", color: "Black")
                }
                break
            case 3:
                if let yellowOrb = yellowOrb {
                    yellowOrb.runAction(SKAction.scaleTo(5, duration: 1.0))
                    self.playSound("SXF_Orb_4", color: "Yellow")
                }
                break
            case 4:
                if let greenOrb = greenOrb {
                    greenOrb.runAction(SKAction.scaleTo(5, duration: 1.0))
                    self.playSound("SXF_Orb_5", color: "Green")
                }
                break
            case 5:
                if let blueOrb = blueOrb {
                    blueOrb.runAction(SKAction.scaleTo(5, duration: 1.0))
                    self.playSound("SXF_Orb_6", color: "Blue")
                }
                break
            case 6:
                if let purpleOrb = purpleOrb {
                    purpleOrb.runAction(SKAction.scaleTo(5, duration: 1.0))
                    self.playSound("SXF_Orb_7", color: "Purple")
                }
                break
            case 7:
                if let whiteOrb = whiteOrb {
                    whiteOrb.runAction(SKAction.scaleTo(5, duration: 1.0))
                    self.playSound("SXF_Orb_1", color: "White")
                }
                break
            default:
                break
            }
        }
    }
    
    // MARK: Sounds
    private func playSound(soundName: String, color: String) {
        let path = NSBundle.mainBundle().pathForResource(soundName, ofType: "m4a")
        if let path = path {
            do {
                let nsurl = NSURL(fileURLWithPath: path)
                switch color {
                case "Cyan":
                    orbPlayer_Cyan = try AVAudioPlayer(contentsOfURL:nsurl)
                    if let player = orbPlayer_Cyan {
                        player.prepareToPlay()
                        player.delegate = self
                        player.play()
                    }
                    break
                case "Red":
                    orbPlayer_Red = try AVAudioPlayer(contentsOfURL:nsurl)
                    if let player = orbPlayer_Red {
                        player.prepareToPlay()
                        player.delegate = self
                        player.play()
                    }
                    break
                case "Black":
                    orbPlayer_Black = try AVAudioPlayer(contentsOfURL:nsurl)
                    if let player = orbPlayer_Black {
                        player.prepareToPlay()
                        player.delegate = self
                        player.play()
                    }
                    break
                case "Yellow":
                    orbPlayer_Yellow = try AVAudioPlayer(contentsOfURL:nsurl)
                    if let player = orbPlayer_Yellow {
                        player.prepareToPlay()
                        player.delegate = self
                        player.play()
                    }
                    break
                case "Green":
                    orbPlayer_Green = try AVAudioPlayer(contentsOfURL:nsurl)
                    if let player = orbPlayer_Green {
                        player.prepareToPlay()
                        player.delegate = self
                        player.play()
                    }
                    break
                case "Blue":
                    orbPlayer_Blue = try AVAudioPlayer(contentsOfURL:nsurl)
                    if let player = orbPlayer_Blue {
                        player.prepareToPlay()
                        player.delegate = self
                        player.play()
                    }
                    break
                case "Purple":
                    orbPlayer_Purple = try AVAudioPlayer(contentsOfURL:nsurl)
                    if let player = orbPlayer_Purple {
                        player.prepareToPlay()
                        player.delegate = self
                        player.play()
                    }
                    break
                case "White":
                    orbPlayer_White = try AVAudioPlayer(contentsOfURL:nsurl)
                    if let player = orbPlayer_White {
                        player.prepareToPlay()
                        player.delegate = self
                        player.play()
                    }
                    break
                default:
                    break
                }
                
            } catch { print("Error getting the audio file") }
        } else { print("Not playing anything!") }
    }
}