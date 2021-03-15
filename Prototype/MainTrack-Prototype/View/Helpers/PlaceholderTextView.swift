//
//  PlaceholderTextView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/12/21.
//

import UIKit

class PlaceholderTextView: UITextView, UITextViewDelegate {
    
    var placeholder: String!
    
    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
        configure()
        format()
    }
    
    private func configure() {
        text = placeholder
        delegate = self
        isScrollEnabled = false
    }
    
    private func format() {
        textColor = .lightGray
        layer.cornerRadius = .cornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray6.cgColor
        font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textColor == .lightGray {
            textColor = .black
            text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if text.isEmpty {
            text = placeholder
            textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        NotificationCenter.default.post(name: .updateTable, object: nil)
    }
    
}
