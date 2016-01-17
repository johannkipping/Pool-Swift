//
//  Controller.swift
//  Pool
//
//  Created by Johann Kipping on 14.01.16.
//  Copyright © 2016 Johann Kipping. All rights reserved.
//

import Foundation

class Controller {
    
    let vector = Vector()
    let collision = Collision()
    let ball = Ball(posV0: [20.0,20.0], dirV0: [0.0,0.0], v0: 0, m0: 20, r0: 20, idx0: 0, inPocket0: false)
    
    var deltaT: CGFloat
    var tableEdges: [CGFloat]
    var arrowPosV: [CGFloat]
    var pockets: [[CGFloat]]
    
    init(){
        arrowPosV = [0,0]
        tableEdges = [0,0,0,0]
        deltaT = 1/60.0
        pockets = [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]]
    }
    
    func initialHit(){
        let direction: [CGFloat] = vector.direction(vector.subtract(arrowPosV, v2: ball.posV))
        let velocity: CGFloat = vector.length(vector.subtract(arrowPosV, v2: ball.posV))
        ball.dirV = direction
        ball.v = velocity
        
    }
    
    func update(){
        ball.nextPosition(deltaT)
        ball.dirV = collision.checkSides(tableEdges, bPos: ball.posV, ballR: ball.r, velDirection: ball.dirV)
        //ball.inPocket = collision.checkPocket(<#T##pockets: [[CGFloat]]##[[CGFloat]]#>, bPos: <#T##[CGFloat]#>)
    }
    
}