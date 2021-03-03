//
//  VerticalPaddedStack.swift
//  MainTrack
//
//  Created by Clay Suttner on 3/2/21.
//

import UIKit

class VerticalPaddedStack: UIStackView {
    convenience init(distribution: UIStackView.Distribution, arrangedSubviews: [UIView]) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.distribution = distribution
        axis = .vertical
        spacing = .mainPadding
    }
}
