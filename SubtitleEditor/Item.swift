//
//  Item.swift
//  SwiftSubtitleEditor
//
//  Created by Daniel Hladík on 09/12/2018.
//  Copyright © 2018 Daniel Hladík. All rights reserved.
//

class Item: Equatable {
    private(set) var sequence: Int
    private(set) var beginTime: Time
    private(set) var endTime: Time
    private(set) var text: String
    
    init(sequence: Int, beginTime: Time, endTime: Time, text: String) {
        self.sequence = sequence
        self.beginTime = beginTime
        self.endTime = endTime
        self.text = text
    }
    
    func setSequence(sequence: Int) {
        self.sequence = sequence
    }
    
    func setBeginTime(beginTime: Time) {
        self.beginTime = beginTime
    }
    
    func setEndTime(endTime: Time) {
        self.endTime = endTime
    }
    
    func setText(text: String) {
        self.text = text
    }
    
    static func ==(item1: Item, item2: Item) -> Bool {
        if item1.sequence != item2.sequence || item1.beginTime != item2.beginTime || item1.endTime != item2.endTime || item1.text != item2.text {
            return false
        }
        
        return true
    }
}
