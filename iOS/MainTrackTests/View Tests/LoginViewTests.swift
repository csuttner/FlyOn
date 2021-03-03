//
//  LoginViewTest.swift
//  MainTrackTests
//
//  Created by Clay Suttner on 3/1/21.
//

import Foundation
import XCTest
@testable import MainTrack

class LoginViewTests: XCTestCase {
    
    let testFrame = UIScreen.main.bounds
    
    func test_init_setsCorrectFormatting() {
        XCTAssertEqual(makeSut().backgroundColor?.accessibilityName, UIColor.systemGray.accessibilityName)
        XCTAssertEqual(makeSut().layer.cornerRadius, .cornerRadius)
    }
    
    func test_init_addsStackToLoginView() {
        let sut = makeSut()
        let stack = sut.stack
        
        XCTAssertTrue(sut.subviews.contains(stack))
    }
    
    func test_init_setsStackframeEqualToBoundsInsetByPadding() {
        let sut = makeSut()
        let stack = sut.stack
        
        XCTAssertEqual(stack.frame, sut.bounds.inset(by: .mainPadding))
    }
    
    func makeSut() -> LoginView {
        let sut = LoginView(superviewFrame: testFrame)
        return sut
    }
    
}
