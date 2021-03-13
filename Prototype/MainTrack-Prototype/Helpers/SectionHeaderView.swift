//
//  DefectSectionHeaderView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/8/21.
//

import UIKit

class SectionHeaderView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    convenience init(title: String) {
        self.init()
        setupLabel()
        titleLabel.text = title
        backgroundColor = .systemGray6
    }
    
    func setupLabel() {
        addSubview(titleLabel)
        titleLabel.anchor(
            left: leftAnchor,
            centerY: centerYAnchor,
            paddingLeft: .padding
        )
    }
}
