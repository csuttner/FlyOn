//
//  ActionButton.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = .cornerRadius
    }
    
}

class ActionButton: UIButton {
    
    convenience init(title: String, color: UIColor, target: Any?, action: Selector) {
        self.init(title: title, color: color)
        addTarget(target, action: action, for: .touchUpInside)
        titleLabel?.font = .preferredFont(forTextStyle: .title2)
        setTitle("   \(title)   ", for: .normal)
        tintColor = .white
        layer.cornerRadius = .cornerRadius
    }
    
    convenience init(title: String, color: UIColor) {
        self.init()
        titleLabel?.font = .preferredFont(forTextStyle: .title2)
        tintColor = .white
        layer.cornerRadius = .cornerRadius
        setTitle("   \(title)   ", for: .normal)
        backgroundColor = color
    }
    
}
