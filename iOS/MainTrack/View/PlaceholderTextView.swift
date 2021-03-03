//
//  PlaceholderTextView.swift
//  MainTrack
//
//  Created by Clay Suttner on 3/2/21.
//

import UIKit

class PlaceholderTextView: UITextView, UITextViewDelegate {
    var placeholder: String!
    
    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
        text = placeholder
        delegate = self
        textColor = .lightGray
        layer.cornerRadius = .cornerRadius
        font = UIFont.preferredFont(forTextStyle: .body)
        isScrollEnabled = false
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
}
