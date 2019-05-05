//
//  FileViewModelTests.swift
//  SwiftSubtitleEditorTests
//
//  Created by Daniel Hladík on 17/12/2018.
//  Copyright © 2018 Daniel Hladík. All rights reserved.
//

import XCTest
@testable import SubtitleEditor

class FileViewModelTests: XCTestCase {
    var filePath: URL!
    
    override func setUp() {
        filePath = FileManager.default.temporaryDirectory
        filePath.appendPathComponent("fileViewModelTest.srt")
        
        var content = ""
        content += "1\n"
        content += "00:00:00,001 --> 00:00:00,002\n"
        content += "TEXT-1\n\n"
        content += "2\n"
        content += "00:00:00,003 --> 00:00:00,004\n"
        content += "TEXT-2\n\n"
        
        do {
            try content.write(to: filePath, atomically: false, encoding: .utf8)
        } catch {
            print(error)
        }
    }
    
    override func tearDown() {
        do {
            try FileManager.default.removeItem(at: filePath)
        } catch {
            print(error)
        }
    }
    
    func testLoadFromFile() {
        let viewModel = FileViewModel()
        let result = viewModel.loadFromFile(filePath: filePath)
        
        XCTAssertEqual(result.count, 2)
    }
    
    func testSaveToFile() {
        let item1 = Item(sequence: 1, beginTime: Time(milliseconds: 1), endTime: Time(milliseconds: 2), text: "TEXT-1")
        let item2 = Item(sequence: 2, beginTime: Time(milliseconds: 3), endTime: Time(milliseconds: 4), text: "TEXT-2")
        let items = [item1, item2]
        
        let viewModel = FileViewModel()
        viewModel.saveToFile(filePath: filePath, items: items)
        
        var content = ""
        content += "1\n"
        content += "00:00:00,001 --> 00:00:00,002\n"
        content += "TEXT-1\n\n"
        content += "2\n"
        content += "00:00:00,003 --> 00:00:00,004\n"
        content += "TEXT-2\n\n"
        XCTAssertEqual(try! String(contentsOf: filePath), content)
    }
}
