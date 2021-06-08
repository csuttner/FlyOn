//
//  EnterDefectDetailsViewModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 6/7/21.
//

import Foundation

class EnterDefectDetailsViewModel {
    let aircraftString: String
    
    init(aircraft: Aircraft) {
        aircraftString = aircraft.ac
    }
}
