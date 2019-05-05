//
//  SubtitleViewModelTests.swift
//  SwiftSubtitleEditorTests
//
//  Created by Daniel Hladík on 17/12/2018.
//  Copyright © 2018 Daniel Hladík. All rights reserved.
//

import XCTest
@testable import SubtitleEditor

class SubtitleViewModelTests: XCTestCase {
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testRemove() {
        let item1 = Item(sequence: 1, beginTime: Time(milliseconds: 1), endTime: Time(milliseconds: 2), text: "TEXT-1")
        let item2 = Item(sequence: 2, beginTime: Time(milliseconds: 3), endTime: Time(milliseconds: 4), text: "TEXT-2")
        let item3 = Item(sequence: 3, beginTime: Time(milliseconds: 5), endTime: Time(milliseconds: 6), text: "TEXT-3")
        let items = [item1, item2, item3]
        
        let viewModel = SubtitleViewModel()
        viewModel.setItems(items: items)
        viewModel.remove(indexSet: IndexSet(0...1))
        
        XCTAssertFalse(viewModel.items.contains { $0 == item1 })
        XCTAssertFalse(viewModel.items.contains { $0 == item2 })
        XCTAssertTrue(viewModel.items.contains { $0 == item3 })
    }
    
    func testSetItems() {
        let item1 = Item(sequence: 1, beginTime: Time(milliseconds: 1), endTime: Time(milliseconds: 2), text: "TEXT-1")
        let item2 = Item(sequence: 2, beginTime: Time(milliseconds: 3), endTime: Time(milliseconds: 4), text: "TEXT-2")
        let item3 = Item(sequence: 3, beginTime: Time(milliseconds: 5), endTime: Time(milliseconds: 6), text: "TEXT-3")
        let items = [item1, item2]
        
        let viewModel = SubtitleViewModel()
        viewModel.setItems(items: items)
        
        XCTAssertTrue(viewModel.items.contains { $0 == item1 })
        XCTAssertTrue(viewModel.items.contains { $0 == item2 })
        XCTAssertFalse(viewModel.items.contains { $0 == item3 })
    }
    
    func testShift() {
        let item1BeginTime = 1, item1EndTime = 2
        let item1 = Item(sequence: 1, beginTime: Time(milliseconds: item1BeginTime), endTime: Time(milliseconds: item1EndTime), text: "TEXT-1")
        let item2BeginTime = 3, item2EndTime = 4
        let item2 = Item(sequence: 2, beginTime: Time(milliseconds: item2BeginTime), endTime: Time(milliseconds: item2EndTime), text: "TEXT-2")
        
        let indexSet = IndexSet(0...1)
        let milliseconds = 10
        
        let viewModel = SubtitleViewModel()
        viewModel.setItems(items: [item1, item2])
        viewModel.shift(indexSet: indexSet, milliseconds: milliseconds)
        
        XCTAssertEqual(viewModel.items[0].beginTime.toMilliseconds(), (item1BeginTime + milliseconds))
        XCTAssertEqual(viewModel.items[0].endTime.toMilliseconds(), (item1EndTime + milliseconds))
        XCTAssertEqual(viewModel.items[1].beginTime.toMilliseconds(), (item2BeginTime + milliseconds))
        XCTAssertEqual(viewModel.items[1].endTime.toMilliseconds(), (item2EndTime + milliseconds))
    }
}
