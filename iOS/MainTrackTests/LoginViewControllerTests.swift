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
    
    func test_sut_loadsProgrammatically() {
        XCTAssertNotNil(sutFactory())
    }
    
    func sutFactory() -> LoginViewController {
        let sut = LoginViewController()
        _ = sut.view
        return sut
    }
    
}
