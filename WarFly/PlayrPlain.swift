//
//  PlayrPlain.swift
//  WarFly
//
//  Created by СОВА on 28.02.2021.
//

import SpriteKit
import CoreMotion

class PlayerPlane: SKSpriteNode {
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    var leftTextureArrayAnimation = [SKTexture]()
    var rightTextureArrayAnimation = [SKTexture]()
    var forwardTextureArrayAnimation = [SKTexture]()
    var moveDirection: TernDirection = .none
    var stillTurning = false
    
    static func populate(at point: CGPoint) -> PlayerPlane {
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 20
        return playerPlane
    }
    
    func checkPosition() {
        self.position.x += xAcceleration * 50
        
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    func performFly() {
        
        planeAnimationFillArray()
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self] (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
        
        let plainWaitAction = SKAction.wait(forDuration: 1.0)
        let planeDirectionAction = SKAction.run {[unowned self] in
            self.movementDirectionCheck()
        }
        let planeSiqwens = SKAction.sequence([plainWaitAction, planeDirectionAction])
        let planeSequensForevo = SKAction.repeatForever(planeSiqwens)
        self.run(planeSequensForevo)
    }
    
    fileprivate func planeAnimationFillArray() {
    
        SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "PlayerPlane")]) {

            self.leftTextureArrayAnimation = {
                
                var array = [SKTexture]()
                for i in stride(from: 13, through: 1, by: -1) {
                    let number = String(format: "%02d", i)
                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
                    array.append(texture)
                }
                
                SKTexture.preload(array, withCompletionHandler: {
                    print("preload is done")
                })
                return array
                
            }()
            
            self.rightTextureArrayAnimation = {
                
                var array = [SKTexture]()
                for i in stride(from: 13, through: 26, by: 1) {
                    let number = String(format: "%02d", i)
                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
                    array.append(texture)
                }
                
                SKTexture.preload(array, withCompletionHandler: {
                    print("preload is done")
                })
                return array
                
            }()
            
            self.forwardTextureArrayAnimation = {
                
                var array = [SKTexture]()
                let texture = SKTexture(imageNamed: "airplane_3ver2_13")
                array.append(texture)
                
                
                SKTexture.preload(array, withCompletionHandler: {
                    print("preload is done")
                })
                return array
                
            }()
        }
    }
    
    private func movementDirectionCheck() {
        
        if xAcceleration > 0.02, moveDirection != .right, stillTurning == false {
            stillTurning = true
            moveDirection = .right
            turnPlane(direction: .right)
        } else if xAcceleration > 0.02, moveDirection != .light, stillTurning == false {
            stillTurning = true
            moveDirection = .light
            turnPlane(direction: .light)
        } else if stillTurning == false {
            turnPlane(direction: .none)
        }
    }
    
    private func turnPlane(direction: TernDirection) {
        var array = [SKTexture]()
        
        if direction == .right {
            array = rightTextureArrayAnimation
        } else if direction == .light {
            array = leftTextureArrayAnimation
        } else {
            array = forwardTextureArrayAnimation
        }
        
        let forvardAction = SKAction.animate(withNormalTextures: array, timePerFrame: 0.05, resize: true, restore: false)
        let backwardAction = SKAction.animate(withNormalTextures: array, timePerFrame: 0.05, resize: true, restore: false)
        let secuensAction = SKAction.sequence([forvardAction, backwardAction])
        self.run(secuensAction) { [unowned self] in
            self.stillTurning = false
        }
    }
}

enum TernDirection {
    case right
    case light
    case none
}
