//
//  Vector.swift
//  Pool
//
//  Created by Johann Kipping on 14.01.16.
//  Copyright © 2016 Johann Kipping. All rights reserved.
//

import Foundation

class Vector{
    
    func pointToVector(point: CGPoint)->[CGFloat]{
        var result: [CGFloat] = [CGFloat](count: 2, repeatedValue: 0.0)
        result[0] = point.x
        result[1] = point.y
        return result
    }
    
    func vectorToPoint(vector: [CGFloat])->CGPoint{
        let result = CGPointMake(vector[0], vector[1])
        return result
    }
    
    func multiply(v1: [CGFloat], v2: [CGFloat])->CGFloat{
        var result: CGFloat = 0.0
        for(var i=0;i<v1.count;i++){
            result += v1[i] * v2[i]
        }
        return result
    }
    
    func length(v1: [CGFloat])->CGFloat{
        var x: CGFloat = 0.0
        for(var i=0;i<v1.count;i++){
            x += v1[i] * v1[i]
        }
        return sqrt(x)
    }
    
    func direction(v1: [CGFloat])->[CGFloat]{
        var result: [CGFloat] = [CGFloat](count: v1.count, repeatedValue: 0.0)
        let lengt = length(v1)
        for(var i=0;i<v1.count;i++){
            result[i] = v1[i]/lengt
        }
        return result
    }
    
    func angle(v1: [CGFloat], v2: [CGFloat] )->CGFloat{
        return acos(multiply(v1, v2: v2) / (length(v1) * length(v2)))
    }
    
    func add(v1: [CGFloat], v2: [CGFloat] )->[CGFloat]{
        var result:[CGFloat] = [CGFloat](count: v1.count, repeatedValue: 0.0)
        for(var i=0;i<v1.count;i++){
            result[i] = v1[i] + v2[i]
        }
        return result
    }
    
    func subtract(v1: [CGFloat], v2: [CGFloat] )->[CGFloat]{
        var result:[CGFloat] = [CGFloat](count: v1.count, repeatedValue: 0.0)
        for(var i=0;i<v1.count;i++){
            result[i] = v1[i] + v2[i] * (-1)
        }
        return result
    }
    
    func multiplySkalar(v1: [CGFloat], c: CGFloat )->[CGFloat]{
        var result:[CGFloat] = [CGFloat](count: v1.count, repeatedValue: 0.0)
        for(var i=0;i<v1.count;i++){
            result[i] = v1[i] * c
        }
        return result
    }
    
    func normalLine(vector:[CGFloat])-> [CGFloat]{
        var result: [CGFloat] = [CGFloat](count:vector.count, repeatedValue: 0.0)
        if (vector.contains(0)){
            for (var i = 0; i < vector.count; i++){
                if(vector[i] == 0){
                    result[i] = 1
                }
                else{
                    result[i] = 0
                }
            }
        }
        else{
            var x :CGFloat = 0.0
            for (var i = 0; i < vector.count; i++){
                result[i] = 1
                x -= result[i] * vector[i]
            }
            result[vector.count - 1] = x / vector[vector.count - 1]
        }
        return direction(result)
    }
    
    
    //Schnittpunkt zwischen Flaeche(koordinatenform) und Gerade(Richtungsv,Stützvektor)
    func intersectionPlaneLine(plane:[CGFloat], line:[[CGFloat]]) ->[CGFloat]{
        let nR: CGFloat = line[1][0] * plane[0] + line[1][1] * plane[1] + line[1][2] * plane[2]
        let x: CGFloat = plane[3] - (line[0][0] * plane[0] + line[0][1] * plane[1] + line[0][2] * plane[2])
        return add(line[0],v2: multiplySkalar(line[1],c: x/nR))
    }
    
    //errechnet den Normalenvektor aus zwei vektoren
    func normalPlane(v1:[CGFloat], v2:[CGFloat])-> [CGFloat]{
        var result: [CGFloat] = [CGFloat](count:3, repeatedValue: 0.0)
        result[0] = v1[1]*v2[2] - v1[2]*v2[1]
        result[1] = v1[2]*v2[0] - v1[0]*v2[2]
        result[2] = v1[0]*v2[1] - v1[1]*v2[0]
        
        return result;
    }
    
    //Bringt eine Ebene von der Normalenform in die Koordinatenform
    func pNormToCoord(norm:[[CGFloat]] )-> [CGFloat]{
        var result: [CGFloat] = [CGFloat](count:4, repeatedValue: 0.0)
        for(var i = 0; i < 3; i++){
            result[i] = norm[1][i]
        }
        result[3] = multiply(norm[0],v2: norm[1])
        return result
    }
    
    //Bringt eine Ebene von der Parameterform in die Normalenform
    func pParaToNorm (para:[[CGFloat]])->[[CGFloat]]{
        var result: [[CGFloat]] = Array(count: 2, repeatedValue: Array(count: 3, repeatedValue:0.0))
        result[0] = para[0]
        result[1] = normalPlane(para[1],v2: para[2])
    
        return result
    }
    
    
    //Punkt an einer Gerade gespiegelt
    func mirrorLine (point: [CGFloat],line:[[CGFloat]])->[CGFloat]{
        var result: [CGFloat] = [CGFloat](count: point.count, repeatedValue: 0.0)
        let helpPlane: [[CGFloat]] = [point,line[1]]
        let closestPoint : [CGFloat] = intersectionPlaneLine(pNormToCoord(helpPlane),line: line)
        result = add(point, v2: multiplySkalar(subtract(closestPoint,v2: point),c: 2))
        return result
        
    }
    
}