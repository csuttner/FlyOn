//
//  DefectSectionHeaderView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/8/21.
//

import UIKit

class SectionHeader: UIView {
    let titleLabel = UILabel()
    
    convenience init(title: String) {
        self.init()
        backgroundColor = .systemGray6
        addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        titleLabel.pin(to: self, horizPadding: .halfPadding, vertPadding: .padding)
    }
}
