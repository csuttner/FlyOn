//
//  DefectSectionHeaderView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/8/21.
//

import UIKit

class SectionHeaderView: UIView {
    let titleLabel = UILabel()
    
    convenience init(title: String) {
        self.init()
        self.titleLabel.text = title
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        addSubview(titleLabel)
        titleLabel.anchor(
            left: leftAnchor,
            centerY: centerYAnchor,
            paddingLeft: .padding
        )
        backgroundColor = .systemGray6
    }
}
