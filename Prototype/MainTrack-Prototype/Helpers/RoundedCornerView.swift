//
//  RoundedCornerView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class RoundedCornerView: UIView {
    
    convenience init() {
        self.init(frame: .zero)
        layer.cornerRadius = .cornerRadius
        backgroundColor = .systemGray6
    }
    
}
