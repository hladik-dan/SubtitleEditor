//
//  TimeTests.swift
//  SwiftSubtitleEditorTests
//
//  Created by Daniel Hladík on 16/12/2018.
//  Copyright © 2018 Daniel Hladík. All rights reserved.
//

import XCTest
@testable import SubtitleEditor

class TimeTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testConstructor_PositiveTime() {
        let time = Time(milliseconds: 12345678)
        
        XCTAssertEqual(time.hours, 3)
        XCTAssertEqual(time.minutes, 25)
        XCTAssertEqual(time.seconds, 45)
        XCTAssertEqual(time.milliseconds, 678)
    }
    
    func testConstructor_NegativeTime() {
        let time = Time(milliseconds: -12345678)
        
        XCTAssertEqual(time.hours, -3)
        XCTAssertEqual(time.minutes, -25)
        XCTAssertEqual(time.seconds, -45)
        XCTAssertEqual(time.milliseconds, -678)
    }

    func testDescription1() {
        let time = Time(hours: 1, minutes: 2, seconds: 3, milliseconds: 4)
        
        XCTAssertEqual(String(describing: time), "01:02:03,004")
    }
    
    func testDescription2() {
        let time = Time(hours: -1, minutes: -2, seconds: -3, milliseconds: -4)
        
        XCTAssertEqual(String(describing: time), "01:02:03,004")
    }
    
    func testFromString() {
        let time = Time.fromString(string: "01:02:03,004")
        
        XCTAssertEqual(time.hours, 1)
        XCTAssertEqual(time.minutes, 2)
        XCTAssertEqual(time.seconds, 3)
        XCTAssertEqual(time.milliseconds, 4)
    }

    func testPlusOperator1() {
        let time1 = Time(hours: 1, minutes: 2, seconds: 3, milliseconds: 4)
        let time2 = Time(milliseconds: 12345678)
        let result = time1 + time2
        
        XCTAssertEqual(time1.hours, 1)
        XCTAssertEqual(time1.minutes, 2)
        XCTAssertEqual(time1.seconds, 3)
        XCTAssertEqual(time1.milliseconds, 4)
        XCTAssertEqual(result.hours, 4)
        XCTAssertEqual(result.minutes, 27)
        XCTAssertEqual(result.seconds, 48)
        XCTAssertEqual(result.milliseconds, 682)
    }
    
    func testPlusOperator2() {
        let time1 = Time(hours: 1, minutes: 2, seconds: 3, milliseconds: 4)
        let time2 = Time(milliseconds: -12345678)
        let result = time1 + time2
        
        XCTAssertEqual(time1.hours, 1)
        XCTAssertEqual(time1.minutes, 2)
        XCTAssertEqual(time1.seconds, 3)
        XCTAssertEqual(time1.milliseconds, 4)
        XCTAssertEqual(result.hours, -2)
        XCTAssertEqual(result.minutes, -23)
        XCTAssertEqual(result.seconds, -42)
        XCTAssertEqual(result.milliseconds, -674)
    }
    
    func testPlusOperator3() {
        let time1 = Time(hours: 0, minutes: 1, seconds: 2, milliseconds: 345)
        let time2 = Time(milliseconds: -987)
        let result = time1 + time2
        
        XCTAssertEqual(time1.hours, 0)
        XCTAssertEqual(time1.minutes, 1)
        XCTAssertEqual(time1.seconds, 2)
        XCTAssertEqual(time1.milliseconds, 345)
        XCTAssertEqual(result.hours, 0)
        XCTAssertEqual(result.minutes, 1)
        XCTAssertEqual(result.seconds, 1)
        XCTAssertEqual(result.milliseconds, 358)
    }
    
    func testGreaterOperator() {
        let time1 = Time(milliseconds: 100)
        let time2 = Time(milliseconds: -100)
        
        let result = time1 > time2
        
        XCTAssertTrue(result)
    }
}
