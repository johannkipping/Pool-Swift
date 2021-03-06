//
//  AppDelegate.swift
//  Pool
//
//  Created by Johann Kipping on 13.01.16.
//  Copyright (c) 2016 Johann Kipping. All rights reserved.
//


import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        /* Pick a size for the scene */
        if let scene = GameScene(fileNamed:"GameScene") {
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            self.skView!.presentScene(scene)
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            self.skView!.ignoresSiblingOrder = false
            
            self.skView!.showsFPS = true
            self.skView!.showsNodeCount = true
            
            window.acceptsMouseMovedEvents = true
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
