//
//  Ball.swift
//  Pool
//
//  Created by Johann Kipping on 14.01.16.
//  Copyright © 2016 Johann Kipping. All rights reserved.
//

import Foundation

class Ball{
    
    let vector = Vector()
    
    var posV: [CGFloat]
    var dirV : [CGFloat]
    var v: CGFloat
    let m: CGFloat
    var r: CGFloat
    let idx: Int
    let inPocket: Bool
    
    init(posV0: [CGFloat], dirV0 : [CGFloat], v0: CGFloat,m0: CGFloat, r0: CGFloat, idx0: Int, inPocket0: Bool){
        posV = posV0
        dirV = posV0
        v = v0
        m = m0
        r = r0
        idx = idx0
        inPocket = inPocket0
        
    }
    
    func nextPosition(deltaT: CGFloat){
        v = calculateFriction(v)
        posV = vector.add(posV, v2: vector.multiplySkalar((vector.multiplySkalar(dirV, c: v)), c: (deltaT)))
    }
    
    func calculateFriction(v: CGFloat) ->CGFloat{
        if(v<3){
            return 0
        }
        return (v-v/100)
        
    }
}