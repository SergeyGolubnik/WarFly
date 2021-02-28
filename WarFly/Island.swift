//
//  Island.swift
//  WarFly
//
//  Created by СОВА on 27.02.2021.
//

import SpriteKit
import GameplayKit

final class Island: SKSpriteNode, GameBackgraundSpritabl {
    
    static func populate(at point: CGPoint) -> Island {
        
        let imageName = configureName()
        let island = Island(imageNamed: imageName)
        island.setScale(randomScaleFactor)
        island.position = point
        island.zPosition = 1
        island.run(rotateForRandomAngle())
        island.run(move(from: point))
        
        return island
    }
    
    private static func configureName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 4)
        let randomNumber = distribution.nextInt()
        let imageName = "is" + "\(randomNumber)"
        
        return imageName
    }
    
    private static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    private static func rotateForRandomAngle() -> SKAction {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return SKAction.rotate(byAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)
    }
    
    private static func move(from point: CGPoint) -> SKAction {
        
        let muviPoint = CGPoint(x: point.x, y: -200)
        let muviDistanse = point.y + 200
        let muviSpeed: CGFloat = 10.0
        let duration = muviDistanse / muviSpeed
        
        return SKAction.move(to: muviPoint, duration: TimeInterval(duration))
    }

}
