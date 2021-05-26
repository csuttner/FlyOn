//
//  LoginView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/12/21.
//

import UIKit

class RoundedView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = .cornerRadius
    }
}

class RoundedDetailView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 6
    }
}
