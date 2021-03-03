//
//  VerticalPaddedStackTests.swift
//  MainTrackTests
//
//  Created by Clay Suttner on 3/2/21.
//

import Foundation
import XCTest
@testable import MainTrack

class VerticalPaddedStackTests {
    
    func test_initializes_withVerticalAxisAndMainPaddingSpacing() {
        let sut = makeSut()
        
        XCTAssertEqual(sut.axis, .vertical)
        XCTAssertEqual(sut.spacing, .mainPadding)
    }
    
    func test_intializes_withProvidedDistribution() {
        let sut1 = makeSut(distribution: .fillEqually)
        let sut2 = makeSut(distribution: .fillProportionally)
        
        XCTAssertEqual(sut1.distribution, .fillEqually)
        XCTAssertEqual(sut2.distribution, .fillProportionally)
    }
    
    func test_initializes_withSubviews() {
        let subviews = [UIView(), UIView()]
        let sut = makeSut(arrangedSubviews: subviews)
        
        XCTAssertTrue(sut.arrangedSubviews.contains(subviews))
    }
    
    func makeSut(distribution: UIStackView.Distribution = .fill, arrangedSubviews: [UIView] = [UIView]()) -> VerticalPaddedStack {
        let stack = VerticalPaddedStack(distribution: distribution, arrangedSubviews: arrangedSubviews)
        return stack
    }
    
}
