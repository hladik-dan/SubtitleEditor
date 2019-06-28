//
//  Formatter.swift
//  SwiftSubtitleEditor
//
//  Created by Daniel Hladík on 15/12/2018.
//  Copyright © 2018 Daniel Hladík. All rights reserved.
//

import Cocoa

class TimeFormatter: Formatter {
    private(set) var useSign = false
    
    override func string(for obj: Any?) -> String? {
        let value = obj as! Int
        var absValue = abs(value)
        
        let hours = Int(floor(Double(absValue) / Double(Time.Milliseconds.Hour)))
        absValue -= hours * Time.Milliseconds.Hour
        
        let minutes = Int(floor(Double(absValue) / Double(Time.Milliseconds.Minute)))
        absValue -= minutes * Time.Milliseconds.Minute
        
        let seconds = Int(floor(Double(absValue) / Double(Time.Milliseconds.Second)))
        absValue -= seconds * Time.Milliseconds.Second
        
        let milliseconds = absValue
        
        var string = String(format: "%02i:%02i:%02i,%03i", hours, minutes, seconds, milliseconds)
        
        if useSign {
            string = getSign(value) + string
        }
        
        return string
    }
    
    func useSign(_ useSign: Bool) {
        self.useSign = useSign
    }
    
    private func getSign(_ value: Int) -> String {
        if value > 0 {
            return "+"
        }
        
        if value < 0 {
            return "-"
        }
        
        return ""
    }
}
