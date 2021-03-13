//
//  ViewContainer.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

class ViewContainer<T: UIView>: UIView {
    
    public var view = T()
    
    convenience init(view: T? = nil, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0) {
        self.init()
        if let view = view {
            self.view = view
        }
        addSubview(self.view)
        self.view.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: paddingTop,
            paddingLeft: paddingLeft,
            paddingBottom: paddingBottom,
            paddingRight: paddingRight
        )
    }
    
}
