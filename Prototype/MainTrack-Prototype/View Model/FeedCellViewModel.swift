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
    var timeSymbol: String = ""
    
    init(defect: Defect) {
        if defect.isResolved {
            image = UIImage(systemName: "checkmark.circle")!
            tintColor = UIColor.systemGray2.withGreenHue(saturation: 1)
        } else {
            image = UIImage(systemName: "xmark.circle")!
            tintColor = UIColor.systemGray4.withRedHue(saturation: 1)
        }
        
        heading = "\(defect.creatorName) / \(defect.sta) - \(defect.ac) - \(defect.id)"
        description = defect.defectDescription
        
        if let createdDate = defect.createdDate.getDate() {
            timeSymbol = createdDate.timeSymbol
        }
    }
}
