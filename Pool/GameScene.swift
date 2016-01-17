//
//  GameScene.swift
//  Pool
//
//  Created by Johann Kipping on 13.01.16.
//  Copyright (c) 2016 Johann Kipping. All rights reserved.
//

import SpriteKit
import Foundation

class GameScene: SKScene {
    
    //create Objects
    let controller = Controller()
    
    let ball = SKSpriteNode(imageNamed:"ball")
    let arrow = SKSpriteNode(imageNamed:"arrow")
    
    
    var lastUpdateTime: CFTimeInterval = 0
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        
        let table = SKSpriteNode(imageNamed:"table")
        table.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        table.setScale(0.5)
        controller.tableEdges = [CGRectGetMaxX(table.frame)-CGRectGetMaxX(table.frame)/30, CGRectGetMinX(table.frame)+CGRectGetMaxX(table.frame)/30, CGRectGetMaxY(table.frame)-CGRectGetMaxY(table.frame)/20, CGRectGetMinY(table.frame)+CGRectGetMaxY(table.frame)/20]
        
        ball.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        ball.setScale(0.07)
        controller.ball.r = ball.frame.height/2
        controller.ball.posV = controller.vector.pointToVector(ball.position)
        
        arrow.setScale(0.05)
        
        
        self.addChild(table)
        self.addChild(ball)
        self.addChild(arrow)

    }
    
    override func mouseMoved(event: NSEvent) {
        
        let location = event.locationInNode(self)
        arrow.position = location;
        controller.arrowPosV = controller.vector.pointToVector(arrow.position)
        
        let action = SKAction.rotateToAngle(getAngle(), duration: 0.001)
        arrow.runAction(action)
        
    }
    
    func getAngle()->CGFloat{
        let angle = atan2((controller.arrowPosV[1]-controller.ball.posV[1]),(controller.arrowPosV[0]-controller.ball.posV[0]))
        return angle
    }

    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        let location = theEvent.locationInNode(self)
        
        controller.arrowPosV = controller.vector.pointToVector(location)
        
        if(controller.ball.v == 0){
            controller.initialHit()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        controller.update()
        
        ball.position = controller.vector.vectorToPoint(controller.ball.posV)

        controller.deltaT = max(1.0/30.0, CGFloat(currentTime - lastUpdateTime))
        lastUpdateTime = currentTime
        
    }
}

