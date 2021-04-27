//
//  FeedCellViewModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 4/23/21.
//

import UIKit

class FeedCellViewModel {
    let image: UIImage
    let tintColor: UIColor
    let heading: String
    let description: String
    
    init(defect: Defect) {
        if defect.isResolved {
            image = UIImage(systemName: "checkmark.circle")!
            tintColor = UIColor.systemGray2.withGreenHue(saturation: 1)
        } else {
            image = UIImage(systemName: "xmark.circle")!
            tintColor = UIColor.systemGray4.withRedHue(saturation: 1)
        }
        
        heading = "\(defect.sta) - \(defect.ac) - \(defect.ata4.prefix(4)) - \(defect.id)"
        description = defect.defectDescription
    }
}
