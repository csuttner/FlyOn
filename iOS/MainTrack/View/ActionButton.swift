//
//  ActionButton.swift
//  MainTrack
//
//  Created by Clay Suttner on 3/2/21.
//

import UIKit

class ActionButton: UIButton {
    convenience init(title: String, color: UIColor) {
        self.init()
        setTitle(title, for: .normal)
        backgroundColor = color
        layer.cornerRadius = .cornerRadius
    }
}
