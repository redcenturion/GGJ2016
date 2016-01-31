//
//  GameplayScene.swift
//  Lightkeeper
//
//  Created by Steven Yang on 1/30/16.
//  Copyright © 2016 GGJ2016. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class GameplayScene: SKScene, AVAudioPlayerDelegate {
    
    // MARK: Variables
    private let world: SKNode = SKNode()
    private var player: SKSpriteNode?
    private var sun: SKSpriteNode?
    private var orbPlayer_Cyan: AVAudioPlayer?
    private var orbPlayer_Red: AVAudioPlayer?
    private var orbPlayer_Black: AVAudioPlayer?
    private var orbPlayer_Yellow: AVAudioPlayer?
    private var orbPlayer_Green: AVAudioPlayer?
    private var orbPlayer_Blue: AVAudioPlayer?
    private var orbPlayer_Purple: AVAudioPlayer?
    private var orbPlayer_White: AVAudioPlayer?
    private var bgmPlayer_1: AVAudioPlayer?
    private var bgmPlayer_2: AVAudioPlayer?
    private var bgmPlayer_3: AVAudioPlayer?
    private var bgmPlayer_4: AVAudioPlayer?
    
    // Orbs
    private var cyanOrb: SKShapeNode?
    private var redOrb: SKShapeNode?
    private var blackOrb: SKShapeNode?
    private var yellowOrb: SKShapeNode?
    private var greenOrb: SKShapeNode?
    private var blueOrb: SKShapeNode?
    private var purpleOrb: SKShapeNode?
    private var whiteOrb: SKShapeNode?
    private var orbCount: Int = 0
   
    // Constants
    private let MIDSCREEN: CGPoint = CGPointMake(UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height / 2)
    private let PLAYER_SPEED: CGFloat = 3.0
    private let ORB_RADIUS: CGFloat = 30
   
    // Movement
    private var touchPosition: CGPoint = CGPointZero
    private var distanceToMove: CGFloat = 0
    private var fingerOnScreenTime: Double = 0
    private var playerShouldMove: Bool = false
    private var playerMovingRight: Bool = false
    private var jumpAmount: CGFloat = 0
    
    // Layers
    private var firstLayer: SKShapeNode?
    private var secondLayer: SKShapeNode?
    private var thirdLayer: SKShapeNode?
    private var fourthLayer: SKShapeNode?
    
    // MARK: Lifecycle
    override func didMoveToView(view: SKView) {
        print("We are now in the gameplay scene")
       
        // Set up AVPlayers
        orbPlayer_Cyan = AVAudioPlayer()
        orbPlayer_Red = AVAudioPlayer()
        orbPlayer_Black = AVAudioPlayer()
        orbPlayer_Yellow = AVAudioPlayer()
        orbPlayer_Green = AVAudioPlayer()
        orbPlayer_Blue = AVAudioPlayer()
        orbPlayer_Purple = AVAudioPlayer()
        orbPlayer_White = AVAudioPlayer()
        bgmPlayer_1 = AVAudioPlayer()
        bgmPlayer_2 = AVAudioPlayer()
        bgmPlayer_3 = AVAudioPlayer()
        bgmPlayer_4 = AVAudioPlayer()
       
        // Setup
        setupWorld()
        setupBackground()
        setupOrbs()
        setupLayers()
        setupPlayer()
        startGame()
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
        
        // Get cloud texture
        let cloud = self.createSpriteFromAtlas(name: "clouds2")
        cloud.zPosition = -3
        cloud.position = CGPointMake(MIDSCREEN.x, MIDSCREEN.y + 20)
        
        // Shrine
        let shrine = self.createSpriteFromAtlas(name: "shrine")
        shrine.zPosition = 5
        shrine.setScale(0.5)
        shrine.position = CGPointMake(MIDSCREEN.x, MIDSCREEN.y - 100)
        
        // Sun
        sun = self.createSpriteFromAtlas(name: "sun")
        if let sun = sun {
            sun.zPosition = -99
            sun.position = CGPointMake(MIDSCREEN.x - 250, MIDSCREEN.y + 50)
            world.addChild(sun)
        }
        
        // Add to the scene
        world.addChild(hill_1)
        world.addChild(hill_2)
        world.addChild(cloud)
        world.addChild(shrine)
    }
    
    private func setupLayers() {
        firstLayer = self.createColorLayerWithUIColor(UIColor.blackColor())
        if let firstLayer = firstLayer {
            world.addChild(firstLayer)
        }
        secondLayer = self.createColorLayerWithUIColor(UIColor.blueColor())
        if let secondLayer = secondLayer {
            world.addChild(secondLayer)
        }
        thirdLayer = self.createColorLayerWithUIColor(UIColor.redColor())
        if let thirdLayer = thirdLayer {
            world.addChild(thirdLayer)
        }
        fourthLayer = self.createColorLayerWithUIColor(UIColor.yellowColor())
        if let fourthLayer = fourthLayer {
            world.addChild(fourthLayer)
        }
    }
    
    private func setupPlayer() {
        player = self.createSpriteFromAtlas(name: "player")
        if let player = player {
        print("Player being loaded")
            player.anchorPoint = CGPointMake(0.5, 0.5)
            player.position = CGPointMake(MIDSCREEN.x, MIDSCREEN.y - 140)
            player.setScale(0.2)
            player.zPosition = 10
            print("Player position is \(player.position)")
            self.addChild(player)
        } else { print("Player not loaded") }
    }
    
    private func startGame() {
        self.performActionBasedOnOrbCount()
        if let firstLayer = firstLayer {
            firstLayer.alpha = 0.5
            firstLayer.hidden = false
        }
    }
    
    private func setupOrbs() {
        cyanOrb = self.createOrbWithColorValues(r: 0, g: 255, b: 255)
        if let cyanOrb = cyanOrb {
            cyanOrb.position = CGPointMake(100, 200)
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
    
    // MARK: Sprites
    private func createSpriteFromAtlas(name spriteName: String) -> SKSpriteNode {
        let atlas = SKTextureAtlas(named: "sprites")
        let spriteTexture = atlas.textureNamed(spriteName)
        let spriteNode = SKSpriteNode.init(texture: spriteTexture)
        spriteNode.anchorPoint = CGPointMake(0.5,0.5)
       
        return spriteNode
    }
    
    // MARK: Orb
    private func createOrbWithColorValues(r red: CGFloat, g green: CGFloat, b blue: CGFloat, a alpha: CGFloat = 1) -> SKShapeNode {
        let orb = SKShapeNode(circleOfRadius: ORB_RADIUS)
        orb.fillColor = SKColor(red: red, green: green, blue: blue, alpha: alpha)
        orb.strokeColor = SKColor(red: red, green: green, blue: blue, alpha: alpha)
        orb.glowWidth = 10.0
        orb.zPosition = 1000
        
        return orb
    }
    
    private func createOrbTouchRectBasedOffOrbPosition(position: CGPoint) -> CGRect {
        let rect = CGRectMake(position.x, position.y, ORB_RADIUS, ORB_RADIUS)
        return rect
    }
    
    private func performActionBasedOnOrbCount() {
        switch orbCount {
        case 0:
            self.playBGM("Music_Gameplay_1_loop", songNumber: 1)
            break
        case 2:
            if let sun = sun {
                sun.runAction(SKAction.moveTo(CGPointMake(MIDSCREEN.x - 150, MIDSCREEN.y + 100), duration: 3.0))
            }
            secondLayer?.hidden = false
            firstLayer?.runAction(SKAction.fadeAlphaTo(0, duration: 3.0))
            secondLayer?.runAction(SKAction.fadeAlphaTo(0.5, duration: 3.0))
            self.playBGM("Music_Gameplay_2_loop", songNumber: 2)
            break
        case 4:
            if let sun = sun {
                sun.runAction(SKAction.moveTo(CGPointMake(MIDSCREEN.x + 0, MIDSCREEN.y + 130), duration: 3.0))
            }
            thirdLayer?.hidden = false
            secondLayer?.runAction(SKAction.fadeAlphaTo(0, duration: 3.0))
            thirdLayer?.runAction(SKAction.fadeAlphaTo(0.5, duration: 3.0))
            self.playBGM("Music_Gameplay_3_loop", songNumber: 3)
            break
        case 6:
            if let sun = sun {
                sun.runAction(SKAction.moveTo(CGPointMake(MIDSCREEN.x + 150, MIDSCREEN.y + 170), duration: 3.0))
            }
            fourthLayer?.hidden = false
            thirdLayer?.runAction(SKAction.fadeAlphaTo(0, duration: 3.0))
            fourthLayer?.runAction(SKAction.fadeAlphaTo(0.5, duration: 3.0))
            self.playBGM("Music_Gameplay_4_loop", songNumber: 4)
            break
        default:
            break
        }
    }
    
    // MARK: Light
    private func createColorLayerWithUIColor(color: UIColor) -> SKShapeNode {
        let layer = SKShapeNode(rectOfSize: UIScreen.mainScreen().bounds.size)
        layer.fillColor = color
        layer.alpha = 0
        layer.position = MIDSCREEN
        layer.zPosition = 99
        layer.hidden = true
        
        return layer
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
        if let player = player {
            if touchPosition.x > player.position.x {
               playerMovingRight = true
            } else { playerMovingRight = false }
        }
        playerShouldMove = true
        movePlayerToTouchPosition(location: touchPosition)
        orbCount++
        self.performActionBasedOnOrbCount()
        
//        // Play sound on touch location
//        let rand = Int(arc4random_uniform(8))
//        switch rand {
//        case 0:
////            if let cyanOrb = cyanOrb {
////                if CGRectContainsPoint(cyanOrb.frame, touchPosition) {
//                    self.playSound("SXF_Orb_1", color: "Cyan")
////                }
////            }
//            break
//        case 1:
////            if let redOrb = redOrb {
////                if CGRectContainsPoint(redOrb.frame, touchPosition) {
//                    self.playSound("SXF_Orb_2", color: "Red")
////                }
////            }
//            break
//        case 2:
////            if let blackOrb = blackOrb {
////                if CGRectContainsPoint(blackOrb.frame, touchPosition) {
//                    self.playSound("SXF_Orb_3", color: "Black")
////                }
////            }
//            break
//        case 3:
////            if let yellowOrb = yellowOrb {
////                if CGRectContainsPoint(yellowOrb.frame, touchPosition) {
//                    self.playSound("SXF_Orb_4", color: "Yellow")
////                }
////            }
//            break
//        case 4:
////            if let greenOrb = greenOrb {
////                if CGRectContainsPoint(greenOrb.frame, touchPosition) {
//                    self.playSound("SXF_Orb_5", color: "Green")
////                }
////            }
//            break
//        case 5:
////            if let blueOrb = blueOrb {
////                if CGRectContainsPoint(blueOrb.frame, touchPosition) {
//                    self.playSound("SXF_Orb_6", color: "Blue")
////                }
////            }
//            break
//        case 6:
////            if let purpleOrb = purpleOrb {
////                if CGRectContainsPoint(purpleOrb.frame, touchPosition) {
//                    self.playSound("SXF_Orb_7", color: "Purple")
////                }
////            }
//            break
//        case 7:
////            if let whiteOrb = whiteOrb {
////                if CGRectContainsPoint(whiteOrb.frame, touchPosition) {
//                    self.playSound("SXF_Orb_1", color: "White")
////                }
////            }
//            break
//        default:
//            break
//        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        print("Your touch has ended!")
//        jumpAmount = 100
        playerShouldMove = false
        fingerOnScreenTime = 0
    }
    
    override func update(currentTime: NSTimeInterval) {
        guard let player = player else { return }
       
        // Ensure only run when player has finger on screen
        if playerShouldMove {
            fingerOnScreenTime += 0.1
        } else { return }
        
//        if abs(jumpAmount) < 0.2 { jumpAmount = 0 } else { jumpAmount -= 1 }
        //if abs(distanceToMove) < 0.2 { return }
       
//        if distanceToMove >= 0 {
//            distanceToMove -= CGFloat(fingerOnScreenTime)
//            player.position = CGPointMake(player.position.x + CGFloat(fingerOnScreenTime), player.position.y)
//        } else if  distanceToMove < 0 {
//            distanceToMove += CGFloat(fingerOnScreenTime)
//            player.position = CGPointMake(player.position.x - CGFloat(fingerOnScreenTime), player.position.y)
//        }
        if playerMovingRight {
            player.position = CGPointMake(player.position.x + CGFloat(fingerOnScreenTime), player.position.y + jumpAmount)
        } else { player.position = CGPointMake(player.position.x - CGFloat(fingerOnScreenTime), player.position.y + jumpAmount) }
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
    
    private func playBGM(soundName: String, songNumber: Int) {
        let path = NSBundle.mainBundle().pathForResource(soundName, ofType: "m4a")
        if let path = path {
        do {
                let nsurl = NSURL(fileURLWithPath: path)
                switch songNumber {
                case 1:
                    bgmPlayer_1 = try AVAudioPlayer(contentsOfURL:nsurl)
                    if let audioPlayer = bgmPlayer_1 {
                        audioPlayer.prepareToPlay()
                        audioPlayer.delegate = self
                        audioPlayer.play()
                    }
                    break
                case 2:
                    bgmPlayer_2 = try AVAudioPlayer(contentsOfURL:nsurl)
                    if let audioPlayer = bgmPlayer_2 {
                        audioPlayer.prepareToPlay()
                        audioPlayer.delegate = self
                        audioPlayer.play()
                    }
                    break
                case 3:
                bgmPlayer_3 = try AVAudioPlayer(contentsOfURL:nsurl)
                    if let audioPlayer = bgmPlayer_3 {
                        audioPlayer.prepareToPlay()
                        audioPlayer.delegate = self
                        audioPlayer.play()
                    }
                    break
                case 4:
                bgmPlayer_4 = try AVAudioPlayer(contentsOfURL:nsurl)
                if let audioPlayer = bgmPlayer_4 {
                    audioPlayer.prepareToPlay()
                    audioPlayer.delegate = self
                    audioPlayer.play()
                }
                    break
                default:
                    break
                }
            } catch { print("Error getting the audio file") }
        } else { print("Not playing anything!") }
    }
}
