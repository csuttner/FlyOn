//
//  TextFieldExtensions.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/12/21.
//

import UIKit

extension UITextField {
    func withTextStyle(_ style: UIFont.TextStyle) -> UITextField {
        self.font = .preferredFont(forTextStyle: style)
        return self
    }
}
