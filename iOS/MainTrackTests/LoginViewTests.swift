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
    
    func test_subviews_addedToStack() {
        let sut = makeSut()
        let stack = sut.stack
        let subviews = [sut.emplIdText, sut.passwordText, sut.loginButton]
        
        XCTAssertTrue(stack.arrangedSubviews.contains(subviews))
    }
    
    func test_frame_isSetAppropriately() {
        let sut = makeSut()
    }
    
    func makeSut() -> LoginView {
        let sut = LoginView(superviewFrame: testFrame)
        return sut
    }
    
}
