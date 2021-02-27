//
//  Backgraund.swift
//  WarFly
//
//  Created by СОВА on 27.02.2021.
//

import SpriteKit

class Backgraund: SKSpriteNode {
    
    
    static func populatBackgraund(at point: CGPoint) -> Backgraund {
        
        let beckgraund = Backgraund(imageNamed: "background" )
        beckgraund.position = point
        beckgraund.zPosition = 0
        
        return beckgraund
    }
    
}
