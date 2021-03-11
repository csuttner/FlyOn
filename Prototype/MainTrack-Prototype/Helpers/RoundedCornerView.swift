//
//  RoundedCornerView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class RoundedCornerView: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = 8
    }
    
}
