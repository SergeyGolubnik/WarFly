//
//  ProtokolGameExtansion.swift
//  WarFly
//
//  Created by СОВА on 28.02.2021.
//

import SpriteKit
import GameplayKit

protocol GameBackgraundSpritabl {
    static func populate() -> Self
    static func randomPoint() -> CGPoint
}

extension GameBackgraundSpritabl {
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 100, highestValue: Int(screen.size.width) + 200)
        let y = CGFloat(distribution.nextInt())
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        return CGPoint(x: x, y: y)
    }
}
