//
//  StackViewExtensions.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/12/21.
//

import UIKit

extension UIStackView {
    func withAttributes(
        axis: NSLayoutConstraint.Axis = .vertical,
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill
    ) -> UIStackView {
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
        return self
    }
}
