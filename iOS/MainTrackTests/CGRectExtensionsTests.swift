//
//  CGRectExtensionsTests.swift
//  MainTrackTests
//
//  Created by Clay Suttner on 3/1/21.
//

import Foundation
import XCTest
@testable import MainTrack

class CGRectExtensionsTests: XCTestCase {
    
    func test_squareHalfWidth() {
        let factor: CGFloat = 2
        let mainBounds = UIScreen.main.bounds
        let sut = mainBounds.squareWidthDivided(by: factor)
        
        XCTAssertEqual(mainBounds.width / factor, sut.width)
        XCTAssertEqual(mainBounds.width / factor, sut.height)
        XCTAssertEqual(mainBounds.midX, sut.midX)
        XCTAssertEqual(mainBounds.midY, sut.midY)
    }
    
}
