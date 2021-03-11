//
//  MainButton.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class MainButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        titleLabel?.font = .preferredFont(forTextStyle: .title2)
        layer.cornerRadius = 8
    }
    
}
