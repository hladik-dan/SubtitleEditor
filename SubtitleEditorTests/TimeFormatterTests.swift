//
//  TimeFormatterTests.swift
//  SubtitleEditorTests
//
//  Created by Daniel Hladík on 28/06/2019.
//  Copyright © 2019 Daniel Hladík. All rights reserved.
//

import XCTest
@testable import SubtitleEditor

class TimeFormatterTests: XCTestCase {
    var timeFormatter: TimeFormatter!
    
    override func setUp() {
        timeFormatter = TimeFormatter()
    }
    
    override func tearDown() {
    }
    
    func testZeroWithoutSign() {
        let milliseconds = 0;
        
        timeFormatter.useSign(false)
        let result = timeFormatter.string(for: milliseconds)
        
        XCTAssertEqual("00:00:00,000", result)
    }
    
    func testZeroWithSign() {
        let milliseconds = 0;
        
        timeFormatter.useSign(true)
        let result = timeFormatter.string(for: milliseconds)
        
        XCTAssertEqual("00:00:00,000", result)
    }
    
    func testPositiveWithoutSign() {
        let milliseconds = 123456789;
        
        timeFormatter.useSign(false)
        let result = timeFormatter.string(for: milliseconds)
        
        XCTAssertEqual("34:17:36,789", result)
    }
    
    func testPositiveWithSign() {
        let milliseconds = 123456789;
        
        timeFormatter.useSign(true)
        let result = timeFormatter.string(for: milliseconds)
        
        XCTAssertEqual("+34:17:36,789", result)
    }
    
    func testNegativeWithoutSign() {
        let milliseconds = -123456789;
        
        timeFormatter.useSign(false)
        let result = timeFormatter.string(for: milliseconds)
        
        XCTAssertEqual("34:17:36,789", result)
    }
    
    func testNegativeWithSign() {
        let milliseconds = -123456789;
        
        timeFormatter.useSign(true)
        let result = timeFormatter.string(for: milliseconds)
        
        XCTAssertEqual("-34:17:36,789", result)
    }
}
