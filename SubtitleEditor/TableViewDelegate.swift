//
//  TableViewDelegate.swift
//  SwiftSubtitleEditor
//
//  Created by Daniel Hladík on 09/12/2018.
//  Copyright © 2018 Daniel Hladík. All rights reserved.
//

import Cocoa

extension MainViewController: NSTableViewDelegate {
    enum Columns {
        static let Sequence = "No."
        static let BeginTime = "Start"
        static let EndTime = "End"
        static let Text = "Text"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let tableCellView = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
        
        switch tableColumn?.title {
        case Columns.Sequence:
            tableCellView.textField?.stringValue = String(subtitleViewModel.items[row].sequence)
            break
        case Columns.BeginTime:
            tableCellView.textField?.stringValue = String(describing: subtitleViewModel.items[row].beginTime)
            break
        case Columns.EndTime:
            tableCellView.textField?.stringValue = String(describing: subtitleViewModel.items[row].endTime)
            break
        case Columns.Text:
            tableCellView.textField?.stringValue = subtitleViewModel.items[row].text
            break
        default:
            break
        }
        
        return tableCellView
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let numberOfLines = subtitleViewModel.items[row].text.filter { $0 == "\n" }.count + 1
        
        return CGFloat(numberOfLines) * tableView.rowHeight
    }
}
