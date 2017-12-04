//
//  GameScene.swift
//  Ejemplo 1
//
//  Created by Alexis Rogelio León Licea on 19/11/17.
//  Copyright © 2017 Evolution Technologies SA de CV. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let cam = SKCameraNode()
    let player = Player()
    let ground = Ground()
    var screenCenterY = CGFloat()
    let initialPlayersPosition = CGPoint(x: 150,y: 250)
    var playerProgress = CGFloat()
    let encounterManager = EncounterManager()
    
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
