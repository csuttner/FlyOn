//
//  LoadView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/19/21.
//

import UIKit

class LoadingView: UIView {

    let indicator = UIActivityIndicatorView(style: .large)
    
    func show(in view: UIView) {
        frame = view.frame
        backgroundColor = UIColor.systemGray6.withAlphaComponent(0.5)
        setUpIndicator()
        view.addSubview(self)
    }
    
    func remove() {
        removeFromSuperview()
    }
    
    func setUpIndicator() {
        indicator.color = UIColor.systemFill
        addSubview(indicator)
        indicator.frame = frame
        indicator.startAnimating()
    }

}
