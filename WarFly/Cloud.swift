//
//  Claud.swift
//  WarFly
//
//  Created by СОВА on 27.02.2021.
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


final class Cloud: SKSpriteNode, GameBackgraundSpritabl {

    static func populate() -> Cloud {
        
        let imageName = configureName()
        let cloud = Cloud(imageNamed: imageName)
        cloud.setScale(randomScaleFactor)
        cloud.position = randomPoint()
        cloud.zPosition = 10
        cloud.run(move(from: cloud.position))
        
        return cloud
    }
    
    private static func configureName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        let randomNumber = distribution.nextInt()
        let imageName = "cl" + "\(randomNumber)"
        
        return imageName
    }
    
    private static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    private static func move(from point: CGPoint) -> SKAction {
        
        let muviPoint = CGPoint(x: point.x, y: -200)
        let muviDistanse = point.y + 200
        let muviSpeed: CGFloat = 150.0
        let duration = muviDistanse / muviSpeed
        
        return SKAction.move(to: muviPoint, duration: TimeInterval(duration))
    }
}
