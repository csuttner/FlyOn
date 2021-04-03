//
//  PlaceholderTextField.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 4/2/21.
//

import UIKit

class PlaceholderTextField: UITextField {
    convenience init(placeholder: String, isSecureTextEntry: Bool = false) {
        self.init()
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureTextEntry
        format()
    }
    
    private func format() {
        layer.cornerRadius = .cornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray6.cgColor
        autocapitalizationType = .none
        autocorrectionType = .no
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5))
    }
}
