//
//  AircraftCellViewModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 6/3/21.
//

import UIKit

class AircraftCellViewModel {
    let image: UIImage
    let aircraftString: String
    let stationString: String
    
    init(aircraft: Aircraft) {
        image = UIImage(systemName: "airplane.circle.fill")!
        aircraftString = aircraft.ac
        stationString = "TST"
    }
}
