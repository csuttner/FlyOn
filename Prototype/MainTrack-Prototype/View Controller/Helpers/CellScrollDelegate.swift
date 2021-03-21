//
//  CellScrollDelegate.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/14/21.
//

import Foundation

protocol CellScrollDelegate {
    func scrollTo(indexPath: IndexPath)
    func removeSpace()
}

protocol Scrollable {
    var scrollDelegate: CellScrollDelegate! { get set }
}
