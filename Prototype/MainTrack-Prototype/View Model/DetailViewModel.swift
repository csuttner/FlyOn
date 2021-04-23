//
//  DetailViewModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 4/23/21.
//

import UIKit

class DetailViewModel {
    private var defect: Defect?
    
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
    
    let apiClient = ApiClient.shared
    let repository = Repository.shared
    
    init(defect: Defect? = nil) {
        self.defect = defect
        
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
    
    func getDefect() -> Defect? {
        return defect
    }
    
    func getDefectId() -> String? {
        return defect?.id
    }
    
    func getDefectResolved() -> Bool? {
        return defect?.resolved
    }
    
    func validateInput() throws {
        guard !station.isEmpty,
              !aircraft.isEmpty,
              !subchapter.isEmpty,
              !description.isEmpty
        else {
            throw ValidationError.missingData
        }
    }
    
    func getNewDefectFromInput() throws -> Defect {
        try validateInput()
        return Defect(station, aircraft, subchapter, description)
    }
    
    func updateDefectFromInput(_ defect: Defect) throws {
        try validateInput()
        defect.sta = station
        defect.ac = aircraft
        defect.ata4 = subchapter
        defect.description = description
    }
    
    func createDefect() throws {
        defect = try getNewDefectFromInput()
        apiClient.post(defect!)
        repository.addDefectToSections(defect!)
    }
    
    func updateDefect() throws {
        try updateDefectFromInput(defect!)
        apiClient.put(defect!)
    }
    
    func resolveDefect() {
        defect?.resolved = true
    }
    
    func archiveDefect() {
        if let defect = defect {
            apiClient.archive(defect)
        }
    }
}
