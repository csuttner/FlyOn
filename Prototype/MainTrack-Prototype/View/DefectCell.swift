//
//  DefectCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 4/10/21.
//

import UIKit

class DefectCellOld: UITableViewCell {
    @IBOutlet weak var completedIndicator: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var defect: Defect! {
        didSet{
            configureViews()
        }
    }
    
    func configureViews() {
        headingLabel.text = "\(defect.sta) - \(defect.ac) - \(defect.ata4.prefix(4)) - \(defect.id)"
        descriptionLabel.text = defect.description
        setCompletedIndicator()
    }
    
    func setCompletedIndicator() {
        if defect.resolved {
            completedIndicator.image = UIImage(systemName: "checkmark.circle")!
            completedIndicator.tintColor = .systemGreen
        } else {
            completedIndicator.image = UIImage(systemName: "xmark.circle")!
            completedIndicator.tintColor = .systemRed
        }
    }
}
