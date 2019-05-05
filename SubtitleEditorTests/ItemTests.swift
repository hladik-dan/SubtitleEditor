//
//  ItemTests.swift
//  SwiftSubtitleEditorTests
//
//  Created by Daniel Hladík on 16/12/2018.
//  Copyright © 2018 Daniel Hladík. All rights reserved.
//

import XCTest
@testable import SubtitleEditor

class ItemTests: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testConstructor() {
        let sequence = 1
        let beginTime = Time(milliseconds: 2)
        let endTime = Time(milliseconds: 3)
        let text = "TEST"
        let item = Item(sequence: sequence, beginTime: beginTime, endTime: endTime, text: text)
        
        XCTAssertEqual(item.sequence, sequence)
        XCTAssertEqual(item.beginTime, beginTime)
        XCTAssertEqual(item.endTime, endTime)
        XCTAssertEqual(item.text, text)
    }
    
    func testSequence() {
        let item = Item(sequence: 1, beginTime: Time(milliseconds: 2), endTime: Time(milliseconds: 3), text: "TEST")
        let sequence = 2
        
        item.setSequence(sequence: sequence)
        
        XCTAssertEqual(item.sequence, sequence)
    }
    
    func testBeginTime() {
        let item = Item(sequence: 1, beginTime: Time(milliseconds: 2), endTime: Time(milliseconds: 3), text: "TEST")
        let beginTime = Time(milliseconds: 3)
        
        item.setBeginTime(beginTime: beginTime)
        
        XCTAssertEqual(item.beginTime, beginTime)
    }
    
    func testEndTime() {
        let item = Item(sequence: 1, beginTime: Time(milliseconds: 2), endTime: Time(milliseconds: 3), text: "TEST")
        let endTime = Time(milliseconds: 4)
        
        item.setEndTime(endTime: endTime)
        
        XCTAssertEqual(item.endTime, endTime)
    }
    
    func testText() {
        let item = Item(sequence: 1, beginTime: Time(milliseconds: 2), endTime: Time(milliseconds: 3), text: "TEST")
        let text = "TEXT"
        
        item.setText(text: text)
        
        XCTAssertEqual(item.text, text)
    }
}
