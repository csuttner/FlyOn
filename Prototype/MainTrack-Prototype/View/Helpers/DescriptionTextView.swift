//
//  DescriptionTextView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/12/21.
//

import UIKit

class DescriptionTextView: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = .cornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray6.cgColor
    }
}
