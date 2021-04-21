//
//  LoadView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/19/21.
//

import UIKit

class LoadingView: UIView {
    func show(in view: UIView) {
        frame = view.frame
        backgroundColor = UIColor.systemGray6.withAlphaComponent(0.5)
        setUpIndicator()
        view.addSubview(self)
    }
    
    func setUpIndicator() {
        let indicator = UIActivityIndicatorView(style: .large)
        
        addSubview(indicator)
        indicator.color = UIColor.systemFill
        indicator.frame = frame
        indicator.startAnimating()
    }
    
    func remove() {
        removeFromSuperview()
    }
}
