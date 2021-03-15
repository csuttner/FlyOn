//
//  EmptyCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/14/21.
//

import UIKit

class SpacerCell: ScrollableCell {
    
    let spacerView = UIView()
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: "ID")
        backgroundColor = .systemGray6
        contentView.addSubview(spacerView)
        spacerView.pin(to: contentView)
        spacerView.anchor(height: 1000)
    }
}
