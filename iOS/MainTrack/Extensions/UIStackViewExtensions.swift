//
//  StackViewExtensions.swift
//  MainTrack
//
//  Created by Clay Suttner on 3/1/21.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
