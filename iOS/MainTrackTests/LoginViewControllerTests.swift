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
        let sut = sutFactory()
        
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.loginView)
    }

    func test_loginView_isAddedToView() {
        let sut = sutFactory()
        let loginView = sut.loginView
        
        XCTAssertTrue(sut.view.subviews.contains(loginView))
    }
    
    func test_loginStack_isCenteredInView() {
//        let sut = sutFactory()
//        let loginStack = 
    }
    
    func sutFactory() -> LoginViewController {
        let sut = LoginViewController()
        _ = sut.view
        return sut
    }
    
}
