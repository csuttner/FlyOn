//
//  LoginViewControllerTests.swift
//  MainTrackTests
//
//  Created by Clay Suttner on 2/21/21.
//

import Foundation
import XCTest
@testable import MainTrack

class LoginViewControllerTests: XCTestCase {
    
    func test_views_loadProgrammatically() {
        let sut = makeSut()
        
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.loginView)
    }

    func test_loginView_isAddedToView() {
        let sut = makeSut()
        let loginView = sut.loginView
        
        XCTAssertTrue(sut.view.subviews.contains(loginView))
    }
    
    func test_loginView_isCenteredInView() {
        let sut = makeSut()
        let loginView = sut.loginView
        
        XCTAssertEqual(sut.view.frame.midX, loginView.frame.midX)
        XCTAssertEqual(sut.view.frame.midY, loginView.frame.midY)
    }
    
    func test_viewBackground_isSystemBackground() {
        XCTAssertEqual(makeSut().view.backgroundColor, .systemBackground)
    }
    
    func makeSut() -> LoginViewController {
        let sut = LoginViewController()
        _ = sut.view
        return sut
    }
    
}
