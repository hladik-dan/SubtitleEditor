//
//  ViewController.swift
//  SwiftSubtitleEditor
//
//  Created by Daniel Hladík on 09/12/2018.
//  Copyright © 2018 Daniel Hladík. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    @IBOutlet weak var tableView: NSTableView!
    
    @IBAction func fileOpen(_ sender: NSMenuItem) {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["srt"]
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        
        let result = openPanel.runModal()
        
        switch result {
        case .OK:
            subtitleViewModel.setItems(items: fileViewModel.loadFromFile(filePath: openPanel.url!, encoding: fileOpenEncoding(stringEncoding: sender.title)))
            tableView.reloadData()
            break
        default:
            break
        }
    }
    
    @IBAction func fileSave(_ sender: Any) {
        fileViewModel.saveToFile(filePath: fileViewModel.filePath!, items: subtitleViewModel.items)
    }
    
    @IBAction func removeSubtitles(_ sender: Any) {
        subtitleViewModel.remove(indexSet: tableView.selectedRowIndexes)
        tableView.reloadData()
    }
    
    @IBAction func shiftSubtitles(_ sender: Any) {
        self.performSegue(withIdentifier: "ShiftSegue", sender: self)
    }
    
    let app = NSApplication.shared.delegate as! AppDelegate
    let fileViewModel = FileViewModel()
    let subtitleViewModel = SubtitleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func fileOpenEncoding(stringEncoding: String) -> String.Encoding {
        let encoding: String.Encoding
        
        switch stringEncoding.uppercased() {
        case app.openWithEncodingWindows1250.title.uppercased():
            encoding = .windowsCP1250
            break
        case app.openWithEncodingUtf8.title.uppercased():
            encoding = .utf8
            break
        default:
            encoding = .utf8
            break
        }
        
        return encoding
    }
}
