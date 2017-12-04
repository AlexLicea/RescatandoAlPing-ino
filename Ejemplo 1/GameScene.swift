//
//  GameScene.swift
//  Ejemplo 1
//
//  Created by Alexis Rogelio León Licea on 19/11/17.
//  Copyright © 2017 Evolution Technologies SA de CV. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let cam = SKCameraNode()
    let player = Player()
    let ground = Ground()
    var screenCenterY = CGFloat()
    let initialPlayersPosition = CGPoint(x: 150,y: 250)
    var playerProgress = CGFloat()
    let encounterManager = EncounterManager()
    var nextEncounterSpawnPosition = CGFloat(150)
    let powerUpStar = Star()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = .zero
        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        self.camera = cam
        ground.position = CGPoint(x: -self.size.width * 2, y: 30)
        ground.size = CGSize(width: self.size.width * 6, height: 0)
        ground.createChildren()
        self.addChild(ground)
        player.position = initialPlayersPosition
        self.addChild(player)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        screenCenterY = self.size.height/2
        encounterManager.encounters[0].position = CGPoint(x: 400, y: 330)
        encounterManager.addEncountersToScene(gameScene: self)
        self.addChild(powerUpStar)
        powerUpStar.position = CGPoint(x: -2000, y: -2000)
        self.physicsWorld.contactDelegate = self
    }
    
    override func didSimulatePhysics() {
        playerProgress = player.position.x - initialPlayersPosition.x
        var cameraYPos = screenCenterY
        cam.yScale = 1
        cam.xScale = 1
        if (player.position.y > screenCenterY) {
            cameraYPos = player.position.y
            let percentOfMaxHeight = (player.position.y - screenCenterY) / (player.maxHeight - screenCenterY)
            let newScale = 1 + percentOfMaxHeight
            cam.yScale = newScale
            cam.xScale = newScale
        }
        self.camera!.position = CGPoint(x: player.position.x, y:cameraYPos)
        ground.checForReposition(playerProgress: playerProgress)
        // Check to see if we should set a new encounter:
        if player.position.x > nextEncounterSpawnPosition {
            encounterManager.placeNextEncounter(currentXPos: nextEncounterSpawnPosition)
            nextEncounterSpawnPosition += 1200
            // Each encounter has a 10% chance to spawn a star:
            let starRoll = Int(arc4random_uniform(10))
            if starRoll == 0 {
                // Only move the star if it is off the screen.
                if abs(player.position.x - powerUpStar.position.x) > 1200 {
                    // Y Position 50-450:
                    let randomYPos = 50 + CGFloat(arc4random_uniform(400))
                    powerUpStar.position = CGPoint(x: nextEncounterSpawnPosition, y: randomYPos)
                    // Remove any previous velocity and spin:
                    powerUpStar.physicsBody?.angularVelocity = 0
                    powerUpStar.physicsBody?.velocity =
                    CGVector(dx: 0, dy: 0)
                }
                
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            // Find the location of the touch:
            let location = touch.location(in: self)
            // Locate the node at this location:
            let nodeTouched = atPoint(location)
            // Attempt to downcast the node to the GameSprite protocol
            if let gameSprite = nodeTouched as? GameSprite {
                // If this node adheres to GameSprite, call onTap:
                gameSprite.onTap()
            }
        }
        player.startFlapping()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let otherBody:SKPhysicsBody
        let penguinMask = PhysicsCategory.penguin.rawValue | PhysicsCategory.damagedPenguin.rawValue
        if (contact.bodyA.categoryBitMask & penguinMask) > 0 {
            otherBody = contact.bodyB
        }
        else {
            otherBody = contact.bodyA
        }
        switch otherBody.categoryBitMask {
            case PhysicsCategory.ground.rawValue:
                print("hit the ground")
            case PhysicsCategory.enemy.rawValue:
                print("take damage")
            case PhysicsCategory.coin.rawValue:
                print("collect a coin")
            case PhysicsCategory.powerup.rawValue:
                print("start the power-up")
            default:
                print("Contact with no game logic")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.stopFlapping()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.stopFlapping()
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.update()
    }
}

enum PhysicsCategory:UInt32 {
    case penguin = 1
    case damagedPenguin = 2
    case ground = 4
    case enemy = 8
    case coin = 16
    case powerup = 32
}
