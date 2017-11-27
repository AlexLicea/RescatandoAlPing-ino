//
//  GameSprite.swift
//  Ejemplo 1
//
//  Created by Alexis Rogelio León Licea on 26/11/17.
//  Copyright © 2017 Evolution Technologies SA de CV. All rights reserved.
//

import Foundation
import SpriteKit

protocol GameSprite {
    var textureAtlas:SKTextureAtlas { get set }
    var initialSize: CGSize { get set }
    func onTap()
}
