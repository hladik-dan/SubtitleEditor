//
//  ShiftViewController.swift
//  SwiftSubtitleEditor
//
//  Created by Daniel Hladík on 11/12/2018.
//  Copyright © 2018 Daniel Hladík. All rights reserved.
//

import Cocoa

class ShiftViewController: NSViewController {
    @IBOutlet weak var timeStepper: NSStepper!
    @IBOutlet weak var timeTextField: NSTextField!
    @IBOutlet weak var shiftSelectionPopUpButton: NSPopUpButton!
    
    @IBAction func timeStepperAction(_ sender: Any) {
        timeTextField.stringValue = timeFormatter.string(for: timeStepper.integerValue)!
    }
    
    @IBAction func shiftButtonAction(_ sender: Any) {
        let mainViewController = self.presentingViewController as! MainViewController
        var indexSet: IndexSet = []
        
        switch shiftSelectionPopUpButton.selectedItem! {
        case shiftSelectionPopUpButton.item(at: 0):
            indexSet = mainViewController.tableView.selectedRowIndexes
            break
        case shiftSelectionPopUpButton.item(at: 1):
            indexSet = mainViewController.tableView.selectedRowIndexes
            indexSet.insert(integersIn: 0..<mainViewController.tableView.selectedRowIndexes.first!)
            break
        case shiftSelectionPopUpButton.item(at: 2):
            indexSet = mainViewController.tableView.selectedRowIndexes
            indexSet.insert(integersIn: (mainViewController.tableView.selectedRowIndexes.last! + 1)..<mainViewController.subtitleViewModel.items.count)
            break
        default:
            break
        }
        
        mainViewController.subtitleViewModel.shift(indexSet: indexSet, milliseconds: timeStepper.integerValue)
        mainViewController.tableView.reloadData()
        
        dismiss(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeFormatter.useSign(true)
        timeTextField.stringValue = timeFormatter.string(for: timeStepper.integerValue)!
    }
    
    private let timeFormatter = TimeFormatter()
}
