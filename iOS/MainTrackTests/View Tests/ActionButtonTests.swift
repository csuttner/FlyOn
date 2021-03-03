//
//  ActionButtonTests.swift
//  MainTrackTests
//
//  Created by Clay Suttner on 3/2/21.
//

import Foundation
import XCTest
@testable import MainTrack

class ActionButtonTests: XCTestCase {
    
    func test_init_setsCorrectTitle() {
        let button0 = makeSut()
        let button1 = makeSut(title: "title1")
        let button2 = makeSut(title: "title2")
        
        XCTAssertNil(button0.titleLabel?.text)
        XCTAssertEqual(button1.titleLabel?.text, "title1")
        XCTAssertEqual(button2.titleLabel?.text, "title2")
    }
    
    func test_init_setsCorrectColor() {
        let color1: UIColor = .black
        let color2: UIColor = .blue
        let sut1 = makeSut(color: color1)
        let sut2 = makeSut(color: color2)
        
        XCTAssertEqual(sut1.backgroundColor?.accessibilityName, color1.accessibilityName)
        XCTAssertEqual(sut2.backgroundColor?.accessibilityName, color2.accessibilityName)
    }
    
    func test_init_setsCornerRadiusEqualToStaticProperty() {
        XCTAssertEqual(makeSut().layer.cornerRadius, .cornerRadius)
    }
    
    func makeSut(title: String = "", color: UIColor = .clear) -> ActionButton {
        let sut = ActionButton(title: title, color: color)
        return sut
    }
}
