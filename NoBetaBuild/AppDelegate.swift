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
    
    private var window: NSWindow?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        window = NSApp.windows.first
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        window?.makeKeyAndOrderFront(self)
        return false
    }
}

