//
//  AtaTests.swift
//  MainTrackTests
//
//  Created by Clay Suttner on 2/21/21.
//

import Foundation
import XCTest
@testable import MainTrack

class AtaTests: XCTestCase {
    
    let ata4 = 5611
    let subchapterName = "FIXED WINDOWS"
    
    let ata2 = 56
    let chapterName = "WINDOWS"
    
    func test_subchapter_initializesWithProperties() {
        let subchapter = Subchapter(ata4: ata4, subchapterName: subchapterName)
        
        XCTAssertEqual(ata4, subchapter.ata4)
        XCTAssertEqual(subchapterName, subchapter.subchapterName)
    }
    
    func test_chapter_initializesWithProperties() {
        let subchapters = [Subchapter(ata4: ata4, subchapterName: subchapterName)]
        
        let chapter = Chapter(ata2: ata2, chapterName: chapterName, subchapters: subchapters)
        
        XCTAssertEqual(ata2, chapter.ata2)
        XCTAssertEqual(chapterName, chapter.chapterName)
        XCTAssertEqual(subchapters, chapter.subchapters)
    }
    
}
