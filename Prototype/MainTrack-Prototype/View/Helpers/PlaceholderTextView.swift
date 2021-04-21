//
//  PlaceholderTextView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/12/21.
//

import UIKit

@IBDesignable
class PlaceholderTextView: UITextView, UITextViewDelegate {
    
    @objc var placeholder: String!
    
    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
        configure()
        format()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = .cornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray6.cgColor
        font = UIFont.preferredFont(forTextStyle: .body)
        autocapitalizationType = .none
        autocorrectionType = .no
    }
    
    private func configure() {
        text = placeholder
        delegate = self
        isScrollEnabled = false
    }
    
    private func format() {
        textColor = .lightGray
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
