//
//  GameScene.swift
//  WarFly
//
//  Created by СОВА on 27.02.2021.
//

import SpriteKit
import GameplayKit
import  CoreMotion

class GameScene: SKScene {
    
    var player: SKSpriteNode!
    let motionManager = CMMotionManager()
    var xAcceliration: CGFloat = 0
    
    
    override func didMove(to view: SKView) {
        configaStartSibc()
        spawnCload()
        spawnIsland()
    }
     
    private func spawnCload() {
        let spawnCloadWait = SKAction.wait(forDuration: 1)
        let spawnCloadActiot = SKAction.run {
            let cload = Cloud.populate()
            self.addChild(cload)
        }
        
        let spawnCloadSequens = SKAction.sequence([spawnCloadWait, spawnCloadActiot])
        let spawnCloadForevo = SKAction.repeatForever(spawnCloadSequens)
        run(spawnCloadForevo)
    }
    
    private func spawnIsland() {
        let spawnIslandWait = SKAction.wait(forDuration: 2)
        let spawnIslandActiot = SKAction.run {
            let island = Island.populate()
            self.addChild(island)
        }
        
        let spawnIslandSequens = SKAction.sequence([spawnIslandWait, spawnIslandActiot])
        let spawnIslandForevo = SKAction.repeatForever(spawnIslandSequens)
        run(spawnIslandForevo)
    }
    
    
    private func configaStartSibc() {
        
        let scrinCebterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let backgraund = Backgraund.populatBackgraund(at: scrinCebterPoint)
        backgraund.size = self.size
        self.addChild(backgraund)
        
        let scrin = UIScreen.main.bounds

        
        let island1 = Island.populatet(at: CGPoint(x: 100, y: 200))
        self.addChild(island1)
        
        let island2 = Island.populatet(at: CGPoint(x: self.size.width - 100, y: self.size.height - 200))
        self.addChild(island2)
        

        
        player = PlayrPlain.poopilane(at: CGPoint(x: scrin.size.width / 2, y: 100))
        self.addChild(player)
        
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = data {
                let accsileration = data.acceleration
                self.xAcceliration = CGFloat(accsileration.x) * 0.7 + self.xAcceliration * 0.3
            }
        }
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        player.position.x += xAcceliration * 50
        if player.position.x < -70 {
            player.position.x = self.size.width + 70
        } else if player.position.x > self.size.width + 70 {
            player.position.x = -70
        }
    }
}
