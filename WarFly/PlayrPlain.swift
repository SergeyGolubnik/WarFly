//
//  PlayrPlain.swift
//  WarFly
//
//  Created by СОВА on 28.02.2021.
//

import SpriteKit

class PlayrPlain: SKSpriteNode {
    static func poopilane(at point: CGPoint) -> SKSpriteNode {
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        let playerPlane = SKSpriteNode(texture: playerPlaneTexture)
        playerPlane.setScale(0.2)
        playerPlane.position = point
        playerPlane.zPosition = 20
        
        return playerPlane
    }
}
