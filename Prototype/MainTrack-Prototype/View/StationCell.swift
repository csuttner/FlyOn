//
//  StationCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 6/6/21.
//

import UIKit

class StationCell: UITableViewCell {
    @IBOutlet weak var stationImageView: UIImageView!
    @IBOutlet weak var stationLabel: UILabel!
    
    func configure(with viewModel: StationCellViewModel) {
        stationImageView.image = viewModel.image
        stationLabel.text = viewModel.stationString
    }
}
