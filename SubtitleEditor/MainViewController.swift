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
            do {
                let encoding = fileOpenEncoding(stringEncoding: sender.title)
                let items = try fileViewModel.loadFromFile(openPanel.url!, encoding: encoding)
                
                subtitleViewModel.setItems(items)
                tableView.reloadData()
                
                mainWindowController.setTitle(title: openPanel.url!.lastPathComponent)
                app.save.isEnabled = true
                app.revertToSaved.isEnabled = true
            } catch {
                let alert = NSAlert()
                alert.alertStyle = .warning
                alert.messageText = error.localizedDescription
                alert.addButton(withTitle: "OK")
                
                alert.runModal()
            }
            
            break
        default:
            break
        }
    }
    
    @IBAction func fileSave(_ sender: NSMenuItem) {
        fileViewModel.saveToFile(fileViewModel.filePath!, items: subtitleViewModel.items)
    }
    
    @IBAction func fileRevertToSaved(_ sender: NSMenuItem) {
        let filePath = fileViewModel.filePath!
        let encoding = fileViewModel.encoding!
        let items = try! fileViewModel.loadFromFile(filePath, encoding: encoding)
        
        subtitleViewModel.setItems(items)
        tableView.reloadData()
    }
    
    @IBAction func fileClose(_ sender: NSMenuItem) {
        subtitleViewModel.removeAllItems()
        tableView.reloadData()
        
        mainWindowController.resetTitle()
        app.revertToSaved.isEnabled = false
        app.save.isEnabled = false
    }
    
    @IBAction func removeSubtitles(_ sender: NSMenuItem) {
        subtitleViewModel.removeItems(indexSet: tableView.selectedRowIndexes)
        tableView.reloadData()
    }
    
    @IBAction func shiftSubtitles(_ sender: NSMenuItem) {
        self.performSegue(withIdentifier: "ShiftSegue", sender: self)
    }
    
    @IBAction func onTextEdit(_ sender: NSTextFieldCell) {
        let row = tableView.selectedRow
        if (row == -1) {
            return
        }
        
        subtitleViewModel.items[row].setText(text: sender.stringValue)
        tableView.noteHeightOfRows(withIndexesChanged: [row])
    }
    
    let app = NSApplication.shared.delegate as! AppDelegate
    let fileViewModel = FileViewModel()
    let subtitleViewModel = SubtitleViewModel()
    
    var mainWindowController: MainWindowController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.mainWindowController = (self.view.window!.windowController as! MainWindowController)
    }
    
    private func fileOpenEncoding(stringEncoding: String) -> String.Encoding {
        let encoding: String.Encoding
        
        switch stringEncoding.uppercased() {
        case app.openWithEncodingIso88591.title.uppercased():
            encoding = .isoLatin1
            break
        case app.openWithEncodingIso88592.title.uppercased():
            encoding = .isoLatin2
            break
        case app.openWithEncodingUtf8.title.uppercased():
            encoding = .utf8
            break
        case app.openWithEncodingWindows1250.title.uppercased():
            encoding = .windowsCP1250
            break
        default:
            encoding = .utf8
            break
        }
        
        return encoding
    }
}
