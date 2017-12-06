//
//  Menu.swift
//  Ejemplo 1
//
//  Created by Alexis Rogelio León Licea on 06/12/17.
//  Copyright © 2017 Evolution Technologies SA de CV. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    let textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "HUD")
    let startButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let backgroundImage = SKSpriteNode(imageNamed: "background-menu")
        backgroundImage.size = CGSize(width: 1024, height: 768)
        backgroundImage.zPosition = -1
        self.addChild(backgroundImage)
        let logoText = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        logoText.text = "Pierre Penguin"
        logoText.position = CGPoint(x: 0, y: 100)
        logoText.fontSize = 60
        self.addChild(logoText)
        let logoTextButtom = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        logoTextButtom.text = "Escape de la Antartida"
        logoTextButtom.position = CGPoint(x: 0, y: 50)
        logoTextButtom.fontSize = 40
        self.addChild(logoTextButtom)
        startButton.texture = textureAtlas.textureNamed("button")
        startButton.size = CGSize(width: 295, height: 76)
        startButton.position = CGPoint(x: 0, y: -20)
        self.addChild(startButton)
        let startText = SKLabelNode(fontNamed: "AvenirNext-BeatyItalic")
        startText.text = "Juego Nuevo"
        startText.verticalAlignmentMode = .center
        startText.position = CGPoint(x: 0, y: 2)
        startText.fontSize = 40
        startText.name = "StartBtn"
        startText.zPosition = 5
        startButton.addChild(startText)
        let pulseAction = SKAction.sequence([SKAction.fadeAlpha(by: 0.5, duration: 0.9),
                                             SKAction.fadeAlpha(by: 0.5, duration: 0.9)])
        startText.run(SKAction.repeatForever(pulseAction))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            if nodeTouched.name == "StartBtn" {
                self.view?.presentScene(GameScene(size: self.size))
            }
        }
    }
    
}
