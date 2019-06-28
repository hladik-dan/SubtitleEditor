//
//  MainWindowController.swift
//  SubtitleEditor
//
//  Created by Daniel Hladík on 28/06/2019.
//  Copyright © 2019 Daniel Hladík. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    private var originalWindowTitle: String!
    
    override func windowDidLoad() {
        self.originalWindowTitle = self.window!.title
    }
    
    func setTitle(title: String) {
        self.window!.title = title
    }
    
    func resetTitle() {
        self.window!.title = self.originalWindowTitle!
    }
}
