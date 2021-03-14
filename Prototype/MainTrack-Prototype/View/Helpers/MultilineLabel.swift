//
//  MultilineLabel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

class MultilineLabel: UILabel {
    convenience init() {
        self.init(frame: .zero)
        numberOfLines = 0
    }
}
