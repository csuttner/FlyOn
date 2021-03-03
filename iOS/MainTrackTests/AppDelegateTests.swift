//
//  AppDelegateTests.swift
//  MainTrackTests
//
//  Created by Clay Suttner on 3/2/21.
//

import Foundation
import XCTest
@testable import MainTrack

class AppDelegateTests: XCTestCase {
    
    func test_didFinishLaunchingWithOptions_setsUpProgrammaticUI() {
        let sut = AppDelegate()
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(sut.window)
        XCTAssertEqual(sut.window!.frame, UIScreen.main.bounds)
        XCTAssertTrue(sut.window!.rootViewController is UINavigationController)
        XCTAssertTrue((sut.window!.rootViewController as! UINavigationController).viewControllers[0] is LoginViewController)
        XCTAssertTrue(sut.window!.isKeyWindow)
        XCTAssertFalse(sut.window!.isHidden)
    }
    
}
