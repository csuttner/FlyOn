//
//  PlaceholderTextViewTests.swift
//  MainTrackTests
//
//  Created by Clay Suttner on 3/2/21.
//

import Foundation
import XCTest
@testable import MainTrack

class PlaceholderTextViewTests: XCTestCase {
    
    func test_init_setsPlaceholderText() {
        let placeholder = "placeholder"
        let sut = makeSut(placeholder: placeholder)
        
        XCTAssertEqual(sut.placeholder, placeholder)
        XCTAssertEqual(sut.text, placeholder)
    }
    
    func test_init_setsCorrectFormatting() {
        XCTAssertEqual(makeSut().layer.cornerRadius, .cornerRadius)
        XCTAssertEqual(makeSut().font, UIFont.preferredFont(forTextStyle: .body))
        XCTAssertFalse(makeSut().isScrollEnabled)
    }
    
    func test_init_setsSelfAsDelegate() {
        let sut = makeSut()
        XCTAssertEqual(sut.delegate?.description, sut.description)
        print(sut.delegate?.description, sut.description)
    }
    
    func test_init_setsGrayTextColor() {
        XCTAssertEqual(makeSut().textColor?.accessibilityName, UIColor.lightGray.accessibilityName)
    }
    
    func test_didBeginEditing_changesTextColorToBlack() {
        let sut = makeSut()
        
        sut.textViewDidBeginEditing(sut)
        
        XCTAssertEqual(sut.textColor?.accessibilityName, UIColor.black.accessibilityName)
    }
    
    func test_didBeginEditing_removesPlaceholderText() {
        let sut = makeSut()
        
        sut.textViewDidBeginEditing(sut)
        
        XCTAssertTrue(sut.text.isEmpty)
    }
    
    func test_didBeginEditing_onlyRemovesPlaceholderText() {
        let sut = makeSut()
        
        sut.textViewDidBeginEditing(sut)
        
        XCTAssertTrue(sut.text.isEmpty)
        
        let newText = "new text"
        sut.text = newText
        sut.textViewDidBeginEditing(sut)
        
        XCTAssertEqual(sut.text, newText)
    }
    
    func test_didEndEditing_putsPlaceholder_ifNoText() {
        let placeholder = "placeholder"
        let sut = makeSut(placeholder: placeholder)
        
        sut.textViewDidBeginEditing(sut)
        
        let newText = "new text"
        sut.text = newText
        sut.textViewDidEndEditing(sut)
        
        XCTAssertEqual(sut.text, newText)
        
        sut.textViewDidBeginEditing(sut)
        sut.text = ""
        
        sut.textViewDidEndEditing(sut)
        
        XCTAssertEqual(sut.text, placeholder)
    }
    
    func makeSut(placeholder: String = "text") -> PlaceholderTextView {
        let sut = PlaceholderTextView(placeholder: placeholder)
        return sut
    }
}
