//
//  FileViewModel.swift
//  SwiftSubtitleEditor
//
//  Created by Daniel Hladík on 09/12/2018.
//  Copyright © 2018 Daniel Hladík. All rights reserved.
//

import Cocoa

class FileViewModel {
    var filePath: URL?
    
    func loadFromFile(filePath: URL, encoding: String.Encoding = .utf8) -> [Item] {
        var items: [Item] = []
        
        do {
            let contents = try String(contentsOf: filePath, encoding: encoding)
                .replacingOccurrences(of: "\r\n", with: "\n")
                .components(separatedBy: "\n\n")
                .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            
            for content in contents {
                var lines = content.components(separatedBy: "\n")
                let sequenceLine = lines.removeFirst()
                let timesLine = lines.removeFirst()
                let textLine = lines.joined(separator: "\n")
                
                let sequence = getSequence(string: sequenceLine)
                let times = getTimes(string: timesLine)
                let text = getText(string: textLine)
                
                let item = Item(sequence: sequence, beginTime: times[Time.Position.Begin], endTime: times[Time.Position.End], text: text)
                items.append(item)
            }
            
            self.filePath = filePath
        } catch {
            print(error)
        }
        
        return items
    }
    
    func saveToFile(filePath: URL, items: [Item]) {
        var content = ""
        
        for item in items {
            content += String(item.sequence) + "\n"
            content += String(describing: item.beginTime) + " --> " + String(describing: item.endTime) + "\n"
            content += item.text + "\n"
            content += "\n"
        }
        
        do {
            try content.write(to: filePath, atomically: false, encoding: .utf8)
        } catch {
            print(error)
        }
    }
    
    private func getSequence(string: String) -> Int {
        let sequence = Int(string)!
        
        return sequence
    }
    
    private func getText(string: String) -> String {
        let text = string
        
        return text
    }
    
    private func getTimes(string: String) -> [Time] {
        let strings = string.components(separatedBy: "-->").map { $0.trimmingCharacters(in: .whitespaces) }
        let beginTime = Time.fromString(string: strings[Time.Position.Begin])
        let endTime = Time.fromString(string: strings[Time.Position.End])
        
        return [beginTime, endTime]
    }
}
