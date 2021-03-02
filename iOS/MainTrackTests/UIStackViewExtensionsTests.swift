//
//  StackViewExtensionsTest.swift
//  MainTrackTests
//
//  Created by Clay Suttner on 3/1/21.
//

import Foundation
import XCTest
@testable import MainTrack

class StackViewExtensionsTests: XCTestCase {
    
    func test_arrangedSubviews_containsArrayOfSubviews() {
        let sut = UIStackView()
        let view1 = UIView()
        let view2 = UIView()
        let subviews = [view1, view2]
        
        sut.addArrangedSubviews(subviews)
        
        XCTAssertTrue(sut.arrangedSubviews.contains(subviews))
    }
    
}
