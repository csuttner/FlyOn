//
//  AircraftCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 6/3/21.
//

import UIKit

class AircraftCell: UITableViewCell {
    @IBOutlet weak var aircraftImageView: UIImageView!
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var aircraftLabel: UILabel!
    
    func configure(with model: AircraftCellViewModel) {
        aircraftImageView.image = model.image
        stationLabel.text = model.stationString
        aircraftLabel.text = model.aircraftString
    }
}
