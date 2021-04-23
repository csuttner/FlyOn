//
//  DetailViewModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 4/23/21.
//

import UIKit

class DetailViewModel {
    let title: String
    let dateString: String
    let station: String
    let aircraft: String
    let subchapter: String
    let description: String
    let statusContainerColor: UIColor
    let statusImage: UIImage
    let statusTintColor: UIColor
    let status: String
    
    init(defect: Defect? = nil) {
        if let defect = defect {
            title = "Defect \(defect.id)"
            
            dateString = defect.defectDate
            
            station = defect.sta
            aircraft = defect.ac
            subchapter = defect.ata4
            description = defect.description
            
            if defect.resolved {
                statusContainerColor = UIColor.white.withGreenHue(saturation: 0.1)
                statusImage = UIImage(systemName: "checkmark.circle")!
                statusTintColor = UIColor.systemGray.withGreenHue(saturation: 1)
                status = "Closed"
            } else {
                statusContainerColor = UIColor.white.withRedHue(saturation: 0.1)
                statusImage = UIImage(systemName: "xmark.circle")!
                statusTintColor = UIColor.systemGray3.withRedHue(saturation: 1)
                status = "Open"
            }
            
        } else {
            title = "New Defect"
            
            dateString = Date().getString()
            
            station = ""
            aircraft = ""
            subchapter = ""
            description = ""
            
            statusContainerColor = .systemGray6
            
            statusImage = UIImage(systemName: "ellipsis.circle")!
            statusTintColor = UIColor.systemGray
            
            status = "Unopened"
        }
    }
}
