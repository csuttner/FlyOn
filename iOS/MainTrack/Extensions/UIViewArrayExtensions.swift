//
//  ViewArrayExtensions.swift
//  MainTrack
//
//  Created by Clay Suttner on 3/1/21.
//

import UIKit

extension Array where Element == UIView {
    
    func contains(_ elements: [UIView]) -> Bool {
        for element in elements {
            if !self.contains(element) {
                return false
            }
        }
        
        return true
    }
}
