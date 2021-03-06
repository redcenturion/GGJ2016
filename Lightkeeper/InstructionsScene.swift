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
    
    enum defaultKeys {
        static let keyOne = "FirstOrb"
        static let keyTwo = "SecondOrb"
        static let keyThree = "ThirdOrb"
        static let keyFour = "FourthOrb"
        static let keyFive = "FifthOrb"
        static let keySix = "SixthOrb"
        static let keySeven = "SeventhOrb"
        static let keyEight = "EighthOrb"
    }
    
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
    private let DELAY_BEFORE_SWITCH_SCREEN: Double = 5.0
    private let ORB_ANIMATION_DURATION: Double = 0.8
    
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
        
        // Transition to Gameplay
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(DELAY_BEFORE_SWITCH_SCREEN * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.switchToGameplayScene()
        })
    }
    
    // MARK: Setup
    private func setupWorld() {
        self.addChild(world)
    }
    private func setupBackground() {
        print("Setting up the background")
        self.backgroundColor = SKColor.lightGrayColor()
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
            var sequence = SKAction.sequence([SKAction.waitForDuration(delay), SKAction.scaleTo(5, duration: ORB_ANIMATION_DURATION)])
            switch element.intValue {
            case 1:
                if let cyanOrb = cyanOrb {
                    cyanOrb.zPosition = counter
                    cyanOrb.runAction(sequence)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                        self.playSound("SXF_Orb_1", color: "Cyan")
                    })
                    self.saveOrbsToUserDefaultsForColor("Cyan", andIndex: Int(counter))
                }
                break
            case 2:
                if let redOrb = redOrb {
                    redOrb.zPosition = counter
                    redOrb.runAction(sequence)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                        self.playSound("SXF_Orb_2", color: "Red")
                    })
                    self.saveOrbsToUserDefaultsForColor("Red", andIndex: Int(counter))
                }
                break
            case 3:
                if let blackOrb = blackOrb {
                    blackOrb.zPosition = counter
                    blackOrb.runAction(sequence)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                        self.playSound("SXF_Orb_3", color: "Black")
                    })
                    self.saveOrbsToUserDefaultsForColor("Black", andIndex: Int(counter))
                }
                break
            case 4:
                if let yellowOrb = yellowOrb {
                    yellowOrb.zPosition = counter
                    yellowOrb.runAction(sequence)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                        self.playSound("SXF_Orb_4", color: "Yellow")
                    })
                    self.saveOrbsToUserDefaultsForColor("Yellow", andIndex: Int(counter))
                }
                break
            case 5:
                if let greenOrb = greenOrb {
                    greenOrb.zPosition = counter
                    greenOrb.runAction(sequence)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                        self.playSound("SXF_Orb_5", color: "Green")
                    })
                    self.saveOrbsToUserDefaultsForColor("Green", andIndex: Int(counter))
                }
                break
            case 6:
                if let blueOrb = blueOrb {
                    blueOrb.zPosition = counter
                    blueOrb.runAction(sequence)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                        self.playSound("SXF_Orb_6", color: "Blue")
                    })
                    self.saveOrbsToUserDefaultsForColor("Blue", andIndex: Int(counter))
                }
                break
            case 7:
                if let purpleOrb = purpleOrb {
                    purpleOrb.zPosition = counter
                    purpleOrb.runAction(sequence)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                        self.playSound("SXF_Orb_7", color: "Purple")
                    })
                    self.saveOrbsToUserDefaultsForColor("Purple", andIndex: Int(counter))
                }
                break
            case 8:
                if let whiteOrb = whiteOrb {
                    whiteOrb.zPosition = counter
                    whiteOrb.runAction(sequence)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                        self.playSound("SXF_Orb_1", color: "White")
                    })
                    self.saveOrbsToUserDefaultsForColor("White", andIndex: Int(counter))
                }
                break
            default:
                break
            }
            delay += 0.5
            counter += 1
        }
    }
    
    private func saveOrbsToUserDefaultsForColor(color: String, andIndex index: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        var key: String = ""
        switch index {
        case 0:
            key = "FirstOrb"
            break
        case 1:
            key = "SecondOrb"
            break
        case 2:
            key = "ThirdOrb"
            break
        case 3:
            key = "FourthOrb"
            break
        case 4:
            key = "FifthOrb"
            break
        case 5:
            key = "SixthOrb"
            break
        case 6:
            key = "SeventhOrb"
            break
        case 7:
            key = "EighthOrb"
            break
        default:
            break
        }
        defaults.setValue(color, forKey: key)
        defaults.synchronize()
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
    
    // MARK: Scenes
    private func switchToGameplayScene() {
        if let scene = self.scene {
            let gameplayScene = GameplayScene(size: scene.size)
            let transition = SKTransition.crossFadeWithDuration(3.0)
            scene.view?.presentScene(gameplayScene, transition: transition)
        } else { print("Not switching scene!") }
    }
}