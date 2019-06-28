//
//  Time.swift
//  SwiftSubtitleEditor
//
//  Created by Daniel Hladík on 09/12/2018.
//  Copyright © 2018 Daniel Hladík. All rights reserved.
//

import Cocoa

class Time: CustomStringConvertible, Equatable {
    enum Maximum {
        static let Hour = 24
        static let Minute = 60
        static let Second = 60
        static let Millisecond = 1000
    }
    
    enum Milliseconds {
        static let Hour = 3600000
        static let Minute = 60000
        static let Second = 1000
    }
    
    enum Position {
        static let Begin = 0
        static let End = 1
    }
    
    private(set) var hours: Int
    private(set) var minutes: Int
    private(set) var seconds: Int
    private(set) var milliseconds: Int
    private(set) var description: String
    
    init(hours: Int = 0, minutes: Int = 0, seconds: Int = 0, milliseconds: Int = 0) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.milliseconds = milliseconds
        
        self.description = String(format: "%02i:%02i:%02i,%03i", abs(self.hours), abs(self.minutes), abs(self.seconds), abs(self.milliseconds))
    }
    
    init(milliseconds: Int = 0) {
        self.hours = 0
        self.minutes = 0
        self.seconds = 0
        self.milliseconds = milliseconds
        
        if abs(self.milliseconds) >= Maximum.Millisecond {
            var seconds = Int(floor(Double(abs(self.milliseconds)) / Double(Maximum.Millisecond)))
            Time.copySign(copyFrom: milliseconds, copyTo: &seconds)
            
            self.seconds += seconds
            self.milliseconds -= seconds * Maximum.Millisecond
        }
        
        if abs(self.seconds) >= Maximum.Second {
            var minutes = Int(floor(Double(abs(self.seconds)) / Double(Maximum.Second)))
            Time.copySign(copyFrom: milliseconds, copyTo: &minutes)
            
            self.minutes += minutes
            self.seconds -= minutes * Maximum.Second
        }
        
        if abs(self.minutes) >= Maximum.Minute {
            var hours = Int(floor(Double(abs(self.minutes)) / Double(Maximum.Minute)))
            Time.copySign(copyFrom: milliseconds, copyTo: &hours)
            
            self.hours += hours
            self.minutes -= hours * Maximum.Minute
        }
        
        self.description = String(format: "%02i:%02i:%02i,%03i", abs(self.hours), abs(self.minutes), abs(self.seconds), abs(self.milliseconds))
    }
    
    func toMilliseconds() -> Int {
        return (hours * Milliseconds.Hour) + (minutes * Milliseconds.Minute) + (seconds * Milliseconds.Second) + milliseconds
    }
    
    static func fromString(string: String) -> Time {
        let components = string.components(separatedBy: CharacterSet(charactersIn: ":,"))
        
        let hours = Int(components[0])!
        let minutes = Int(components[1])!
        let seconds = Int(components[2])!
        let milliseconds = Int(components[3])!
        
        return Time(hours: hours, minutes: minutes, seconds: seconds, milliseconds: milliseconds)
    }
    
    static func +(time1: Time, time2: Time) -> Time {
        return Time(milliseconds: time1.toMilliseconds() + time2.toMilliseconds())
    }
    
    static func >(time1: Time, time2: Time) -> Bool {
        return time1.toMilliseconds() > time2.toMilliseconds()
    }
    
    static func ==(time1: Time, time2: Time) -> Bool {
        return time1.toMilliseconds() == time2.toMilliseconds()
    }
    
    private static func copySign(copyFrom: Int, copyTo: inout Int) {
        if copyFrom < 0 && copyTo > 0 {
            copyTo *= -1
        }
    }
}
