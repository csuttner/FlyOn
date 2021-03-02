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
    
    func test_loginView_initializes() {
        XCTAssertNotNil(makeSut())
    }
    
    func test_stack_addedToLoginView() {
        let sut = makeSut()
        let stack = sut.stack
        
        XCTAssertTrue(sut.subviews.contains(stack))
    }
    
    func test_stack_frameEqualToBoundsInsetByPadding() {
        let sut = makeSut()
        let stack = sut.stack
        
        XCTAssertEqual(stack.frame, sut.bounds.insetBy(dx: .mainPadding, dy: .mainPadding))
    }
    
    func test_stack_axisIsVertical() {
        XCTAssertEqual(makeSut().stack.axis, .vertical)
    }
    
    func test_stack_alignmentIsCenter() {
        
    }
    
    func test_subviews_addedToStack() {
        let sut = makeSut()
        let stack = sut.stack
        let subviews = [sut.emplIdText, sut.passwordText, sut.loginButton]
        
        XCTAssertTrue(stack.arrangedSubviews.contains(subviews))
    }
    
    func test_loginButton_textIsLogin() {
        let title = "login"
        let loginButton = makeSut().loginButton
        
        XCTAssertEqual(loginButton.titleLabel!.text, title)
    }
    
    func test_loginButton_frameSizeEqualsIntrinsicContentSize() {
        XCTAssertEqual(makeSut().loginButton.frame.size, makeSut().loginButton.intrinsicContentSize)
    }
    
    func test_loginButton_backgroundColorIsSystemBlue() {
        XCTAssertEqual(makeSut().loginButton.backgroundColor?.accessibilityName, UIColor.systemBlue.accessibilityName)
    }
    
    func test_formatsCorrectly() {
        XCTAssertEqual(makeSut().backgroundColor?.accessibilityName, UIColor.systemGray.accessibilityName)
        XCTAssertEqual(makeSut().layer.cornerRadius, 8)
    }
    

    
    
    func makeSut() -> LoginView {
        let sut = LoginView(superviewFrame: testFrame)
        return sut
    }
    
}
