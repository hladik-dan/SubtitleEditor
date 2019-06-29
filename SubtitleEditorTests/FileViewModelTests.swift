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
    var filePath_UTF8: URL!
    var filePath_Windows1250: URL!
    
    override func setUp() {
        filePath_UTF8 = FileManager.default.temporaryDirectory
        filePath_UTF8.appendPathComponent("fileViewModelTest_Utf8.srt")
        
        filePath_Windows1250 = FileManager.default.temporaryDirectory
        filePath_Windows1250.appendPathComponent("fileViewModelTest_Windows1250.srt")
        
        var content = ""
        content += "1\n"
        content += "00:00:00,001 --> 00:00:00,002\n"
        content += "TEXT\n\n"
        content += "2\n"
        content += "00:00:00,003 --> 00:00:00,004\n"
        content += "ĚŠČŘŽÝÁÍÉ\n\n"
        
        do {
            try content.write(to: filePath_UTF8, atomically: false, encoding: .utf8)
            try content.write(to: filePath_Windows1250, atomically: false, encoding: .windowsCP1250)
        } catch {
            print(error)
        }
    }
    
    override func tearDown() {
        do {
            try FileManager.default.removeItem(at: filePath_UTF8)
        } catch {
            print(error)
        }
    }
    
    func testLoadFromFile_UTF8() {
        let viewModel = FileViewModel()
        let result = try! viewModel.loadFromFile(filePath_UTF8)
        
        XCTAssertEqual(result.count, 2)
    }
    
    func testLoadFromFile_Windows1250() {
        let viewModel = FileViewModel()
        let result = try! viewModel.loadFromFile(filePath_Windows1250, encoding: .windowsCP1250)
        
        XCTAssertEqual(result.count, 2)
    }
    
    func testLoadFromFile_NonExistingFile() {
        let nonExistingFilePath = URL(fileURLWithPath: "nonExistingFile.txt")
        let viewModel = FileViewModel()
        
        XCTAssertThrowsError(try viewModel.loadFromFile(nonExistingFilePath))
    }
    
    func testLoadFromFile_WrongEncoding() {
        let viewModel = FileViewModel()
        
        XCTAssertThrowsError(try viewModel.loadFromFile(filePath_Windows1250))
    }
    
    func testSaveToFile() {
        let item1 = Item(sequence: 1, beginTime: Time(milliseconds: 1), endTime: Time(milliseconds: 2), text: "TEXT")
        let item2 = Item(sequence: 2, beginTime: Time(milliseconds: 3), endTime: Time(milliseconds: 4), text: "ĚŠČŘŽÝÁÍÉ")
        let items = [item1, item2]
        
        let viewModel = FileViewModel()
        viewModel.saveToFile(filePath_UTF8, items: items)
        
        var content = ""
        content += "1\n"
        content += "00:00:00,001 --> 00:00:00,002\n"
        content += "TEXT\n\n"
        content += "2\n"
        content += "00:00:00,003 --> 00:00:00,004\n"
        content += "ĚŠČŘŽÝÁÍÉ\n\n"
        XCTAssertEqual(try! String(contentsOf: filePath_UTF8), content)
    }
}
