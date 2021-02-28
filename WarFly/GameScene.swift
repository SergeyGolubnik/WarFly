//
//  GameScene.swift
//  WarFly
//
//  Created by СОВА on 27.02.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        
        let scrinCebterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let backgraund = Backgraund.populatBackgraund(at: scrinCebterPoint)
        backgraund.size = self.size
        self.addChild(backgraund)
        
        let scrin = UIScreen.main.bounds
        for _ in 1...5 {
            let x: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(scrin.size.width)))
            let y: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(scrin.size.height)))
            
            let island = Island.populate(at: CGPoint(x: x, y: y))
            self.addChild(island)
            let cloud = Cloud.populate(at: CGPoint(x: x, y: y))
            self.addChild(cloud)
        }
        
    }
}
