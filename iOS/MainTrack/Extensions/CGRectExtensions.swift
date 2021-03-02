//
//  CGRectExtensions.swift
//  MainTrack
//
//  Created by Clay Suttner on 3/1/21.
//

import CoreGraphics

extension CGRect {
    
    func squareWidthDivided(by factor: CGFloat) -> CGRect {
        let widthDelta = (width - (width / factor)) / 2
        let heightDelta = (height - width) / 2 + widthDelta
        return insetBy(dx: widthDelta, dy: heightDelta)
    }
}
