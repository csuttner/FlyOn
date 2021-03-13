//
//  ActionButton.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class ActionButton: UIButton {
    convenience init(title: String, color: UIColor) {
        self.init()
        setTitle(title, for: .normal)
        backgroundColor = color
        format()
    }
    
    func format() {
        titleLabel?.font = .preferredFont(forTextStyle: .title2)
        tintColor = .white
        layer.cornerRadius = .cornerRadius
    }
}
