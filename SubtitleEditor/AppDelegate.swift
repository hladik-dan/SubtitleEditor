//
//  AppDelegate.swift
//  SwiftSubtitleEditor
//
//  Created by Daniel Hladík on 09/12/2018.
//  Copyright © 2018 Daniel Hladík. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var openWithEncodingIso88591: NSMenuItem!
    @IBOutlet weak var openWithEncodingIso88592: NSMenuItem!
    @IBOutlet weak var openWithEncodingUtf8: NSMenuItem!
    @IBOutlet weak var openWithEncodingWindows1250: NSMenuItem!
    @IBOutlet weak var save: NSMenuItem!
    @IBOutlet weak var revertToSaved: NSMenuItem!
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
