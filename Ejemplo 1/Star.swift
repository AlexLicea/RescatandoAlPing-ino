//
//  Star.swift
//  Ejemplo 1
//
//  Created by Alexis Rogelio León Licea on 02/12/17.
//  Copyright © 2017 Evolution Technologies SA de CV. All rights reserved.
//

import Foundation
import SpriteKit

class  Star: SKSpriteNode, GameSprite {
    var initialSize = CGSize(width: 40, height: 38)
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Enviroment")
    var pulseAnimation = SKAction()
    
    init () {
        let starTexture = textureAtlas.textureNamed("star")
        super.init(texture: starTexture, color: .clear, size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.physicsBody?.affectedByGravity = false
        self.run(pulseAnimation)
    }
    
    func createAnimations() {
    let pulseOutGroup = SKAction.group([
        SKAction.fadeAlpha(to: 0.85, duration: 0.8),
        SKAction.scale(to: 0.6, duration: 0.8),
        SKAction.rotate(byAngle: -0.3, duration: 0.8)
        ])
    let pulseInGroup = SKAction.group([
        SKAction.fadeAlpha(to: 1, duration: 1.5),
        SKAction.scale(to: 1, duration: 1.5),
        SKAction.rotate(byAngle: 3.5, duration: 1.5)
        ])
        let pulseSequence = SKAction.sequence([pulseOutGroup,pulseInGroup])
        pulseAnimation = SKAction.repeatForever(pulseSequence)
    }
    
    func onTap() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
