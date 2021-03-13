//
//  DefectSectionHeaderView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/8/21.
//

import UIKit

class SectionHeaderView: UIView {

    convenience init(title: String) {
        self.init()
        let container = ViewContainer<UILabel>(
            paddingTop: .halfPadding,
            paddingLeft: .padding,
            paddingBottom: .halfPadding,
            paddingRight: .padding
        )
        addSubview(container)
        container.pin(to: self)
        container.view.text = title
        container.view.font = .preferredFont(forTextStyle: .title3)
        backgroundColor = .systemGray6
    }

}
