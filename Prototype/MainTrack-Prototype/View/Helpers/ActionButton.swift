//
//  ActionButton.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class RoundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = .cornerRadius
    }
}

class ActionButton: UIButton {
    convenience init(title: String, color: UIColor, target: Any?, action: Selector) {
        self.init()
        titleLabel?.font = .preferredFont(forTextStyle: .title2)
        tintColor = .white
        setTitle("   \(title)   ", for: .normal)
        addTarget(target, action: action, for: .touchUpInside)
        backgroundColor = color
        layer.cornerRadius = .cornerRadius
    }
}
