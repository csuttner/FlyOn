//
//  LoginViewTests.swift
//  MainTrackTests
//
//  Created by Clay Suttner on 2/21/21.
//

import Foundation
import XCTest
@testable import MainTrack

class LoginViewTests: XCTestCase {
    
    func test_loginView_loadsProgrammatically() {
        XCTAssertNotNil(sutFactory())
    }
    
    func sutFactory() -> LoginView {
        let sut = LoginView()
        _ = sut.view
        return sut
    }
    
}
