//
//  SubtitleViewModel.swift
//  SwiftSubtitleEditor
//
//  Created by Daniel Hladík on 09/12/2018.
//  Copyright © 2018 Daniel Hladík. All rights reserved.
//

import Cocoa

class SubtitleViewModel {
    private(set) var items: [Item] = []
    
    func setItems(items: [Item]) {
        self.items = items
    }
    
    func shift(indexSet: IndexSet, milliseconds: Int) {
        for index in indexSet {
            items[index].setBeginTime(beginTime: items[index].beginTime + Time(milliseconds: milliseconds))
            items[index].setEndTime(endTime: items[index].endTime + Time(milliseconds: milliseconds))
        }
    }
    
    func removeItems(indexSet: IndexSet) {
        for (offset, index) in indexSet.enumerated() {
            removeItem(index: index - offset)
        }
    }
    
    func removeAllItems() {
        items.removeAll()
    }
    
    private func removeItem(index: Int) {
        items.remove(at: index)
        
        for item in items[index...] {
            item.setSequence(sequence: item.sequence - 1)
        }
    }
}
