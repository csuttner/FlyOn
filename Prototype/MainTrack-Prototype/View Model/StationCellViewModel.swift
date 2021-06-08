//
//  StationCellViewModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 6/6/21.
//

import UIKit

class StationCellViewModel {
    let image: UIImage
    let stationString: String
    
    init(station: Station) {
        stationString = station.sta
        image = UIImage(systemName: "building.2")!
    }
}
