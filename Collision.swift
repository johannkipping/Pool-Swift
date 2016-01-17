//
//  Collision.swift
//  Pool
//
//  Created by Johann Kipping on 14.01.16.
//  Copyright © 2016 Johann Kipping. All rights reserved.
//

import Foundation

class Collision {
    
    let vector = Vector()
    
    /*
    Überprüft ob Ball mit Spielfeldrand Kollidiert und gibt neuen Richtungsvektor. Ohne Kollision wird die Richtung nicht verändert
    Braucht: - die Koordinaten der Spielfeldbegrenzung in einem Array  der Form{rechts,links,oben,unten}
    -Die Koordianten des Balls als {xKoordiante,yKoordinate}
    - Die Richtung der Bewgung {xKoordiante,yKoordinate} (das Resultat hat die gleich L‰nge wie der Vektor der hier gegeben wird)

    */
    func checkSides(edges:[CGFloat], bPos:[CGFloat], ballR: CGFloat, velDirection:[CGFloat] )-> [CGFloat]{
        var result  : [CGFloat] = velDirection
        if (bPos [0] + ballR >= edges[0] && velDirection[0] >= 0) {
            result[0] = (-1 * velDirection[0] );
        }
        else if (bPos [0] - ballR <= edges[1] && velDirection[0] <= 0) {
            result[0] = (-1 * velDirection[0] );
        }
        if (bPos [1] + ballR >= edges[2] && velDirection[1] >= 0) {
            result[1] = (-1 * velDirection[1] );
        }
        else if (bPos [1] - ballR <= edges[3] && velDirection[1] <= 0) {
            result[1] = (-1 * velDirection[1] );
        }
        return result
    }
    
    func checkPocket(pockets:[[CGFloat]],bPos:[CGFloat]) ->Bool{
        for (var i = 0; i < pockets.count; i++){
            let pPos: [CGFloat] = [pockets[i][0],pockets[i][1]]
            
            if (vector.length(vector.subtract(bPos,v2: pPos)) <= pockets[i][2]){
                return true
            }
            
            
        }
        return false
        
    }
}