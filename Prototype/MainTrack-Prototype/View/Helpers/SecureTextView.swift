//
//  SecureTextView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/31/21.
//

import UIKit

class SecureTextView: PlaceholderTextView {
    
    var originalText: String?
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        originalText = ((originalText ?? "") as NSString).replacingCharacters(in: range, with: text)
        return true
    }
    
    override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        textView.text = String(repeating: "*", count: (textView.text ?? "").count)
    }
    
}
