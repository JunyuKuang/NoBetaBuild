//
//  AppDelegate.swift
//  NoBetaBuild
//
//  Created by Jonny Kuang on 7/18/19.
//  Copyright © 2019 Jonny Kuang. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

