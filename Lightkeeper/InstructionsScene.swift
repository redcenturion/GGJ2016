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
    private var orbArray: NSMutableArray?
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
            cyanOrb.position = CGPointMake(MIDSCREEN.x, MIDSCREEN.y)
            cyanOrb.name = "CyanOrb"
            cyanOrb.setScale(0)
            world.addChild(cyanOrb)
        }
        
        redOrb = self.createOrbWithColorValues(r: 255, g: 0, b: 0)
        if let redOrb = redOrb {
            redOrb.position = CGPointMake(MIDSCREEN.x - 100, MIDSCREEN.y - 100)
            print("Red Orb frame: \(redOrb.frame)")
            redOrb.name = "RedOrb"
            redOrb.setScale(0)
            world.addChild(redOrb)
        }
        
        blackOrb = self.createOrbWithColorValues(r: 0, g: 0 , b: 0)
        if let blackOrb = blackOrb {
            blackOrb.position = CGPointMake(MIDSCREEN.x - 150, MIDSCREEN.y + 100)
            blackOrb.name = "BlackOrb"
            blackOrb.setScale(0)
            world.addChild(blackOrb)
        }
        
        yellowOrb = self.createOrbWithColorValues(r: 255, g: 255, b: 0)
        if let yellowOrb = yellowOrb {
            yellowOrb.position = CGPointMake(MIDSCREEN.x - 180, MIDSCREEN.y - 80)
            yellowOrb.name = "YellowOrb"
            yellowOrb.setScale(0)
            world.addChild(yellowOrb)
        }
        
        greenOrb = self.createOrbWithColorValues(r: 0, g: 255, b: 0)
        if let greenOrb = greenOrb {
            greenOrb.position = CGPointMake(MIDSCREEN.x + 150, MIDSCREEN.y + 120)
            greenOrb.name = "GreenOrb"
            greenOrb.setScale(0)
            world.addChild(greenOrb)
        }
        
        blueOrb = self.createOrbWithColorValues(r: 0, g: 0, b: 255)
        if let blueOrb = blueOrb {
            blueOrb.position = CGPointMake(MIDSCREEN.x - 200, MIDSCREEN.y - 200)
            blueOrb.name = "BlueOrb"
            blueOrb.setScale(0)
            world.addChild(blueOrb)
        }
        
        purpleOrb = self.createOrbWithColorValues(r: 255, g: 0, b: 255)
        if let purpleOrb = purpleOrb {
            purpleOrb.position = CGPointMake(MIDSCREEN.x + 200, MIDSCREEN.y + 200)
            purpleOrb.name = "PurpleOrb"
            purpleOrb.setScale(0)
            world.addChild(purpleOrb)
        }
        
        whiteOrb = self.createOrbWithColorValues(r: 255, g: 255, b: 255)
        if let whiteOrb = whiteOrb {
            whiteOrb.position = CGPointMake(MIDSCREEN.x + 250, MIDSCREEN.y - 180)
            whiteOrb.name = "WhiteOrb"
            whiteOrb.setScale(0)
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
        orbArray = NSMutableArray()
        guard let orbArray = orbArray else { return }
        for element in 1...8 {
            orbArray.addObject(element)
        }
        let count = orbArray.count - 1
        for element in 0...count {
            let remainingCount:Int = count - element
            let exchangeIndex: Int = element + Int(arc4random_uniform(UInt32(remainingCount)))
            orbArray.exchangeObjectAtIndex(count, withObjectAtIndex: exchangeIndex)
        }
        var delay: Double = 0
        var counter: CGFloat = 0
        for element in orbArray {
            var sequence = SKAction.sequence([SKAction.waitForDuration(delay), SKAction.scaleTo(5, duration: 1.0)])
            switch element.intValue {
            case 1:
                if let cyanOrb = cyanOrb {
                    cyanOrb.zPosition = counter
                    cyanOrb.runAction(sequence)
                    self.playSound("SXF_Orb_1", color: "Cyan")
                }
                break
            case 2:
                if let redOrb = redOrb {
                    redOrb.zPosition = counter
                    redOrb.runAction(sequence)
                    self.playSound("SXF_Orb_2", color: "Red")
                }
                break
            case 3:
                if let blackOrb = blackOrb {
                    blackOrb.zPosition = counter
                    blackOrb.runAction(sequence)
                    self.playSound("SXF_Orb_3", color: "Black")
                }
                break
            case 4:
                if let yellowOrb = yellowOrb {
                    yellowOrb.zPosition = counter
                    yellowOrb.runAction(sequence)
                    self.playSound("SXF_Orb_4", color: "Yellow")
                }
                break
            case 5:
                if let greenOrb = greenOrb {
                    greenOrb.zPosition = counter
                    greenOrb.runAction(sequence)
                    self.playSound("SXF_Orb_5", color: "Green")
                }
                break
            case 6:
                if let blueOrb = blueOrb {
                    blueOrb.zPosition = counter
                    blueOrb.runAction(sequence)
                    self.playSound("SXF_Orb_6", color: "Blue")
                }
                break
            case 7:
                if let purpleOrb = purpleOrb {
                    purpleOrb.zPosition = counter
                    purpleOrb.runAction(sequence)
                    self.playSound("SXF_Orb_7", color: "Purple")
                }
                break
            case 8:
                if let whiteOrb = whiteOrb {
                    whiteOrb.zPosition = counter
                    whiteOrb.runAction(sequence)
                    self.playSound("SXF_Orb_1", color: "White")
                }
                break
            default:
                break
            }
            delay += 1
            counter += 1
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