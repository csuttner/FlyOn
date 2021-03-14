//
//  DefectController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/14/21.
//

import Foundation

class DefectController {
    
    static let shared = DefectController()
    
    private init() {}
    
    var defect: Defect?
    
    var mode: DetailMode! {
        didSet {
            NotificationCenter.default.post(name: .changeMode, object: nil)
        }
    }
    
}
