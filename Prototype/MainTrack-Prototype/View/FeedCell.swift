//
//  FeedCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 4/11/21.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var statusIndicator: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(with viewModel: FeedCellViewModel) {
        statusIndicator.image = viewModel.image
        statusIndicator.tintColor = viewModel.tintColor
        headingLabel.text = viewModel.heading
        descriptionLabel.text = viewModel.description
    }
}
