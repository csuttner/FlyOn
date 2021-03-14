//
//  DefectDatabase.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/8/21.
//

import Foundation

class Repository {
    
    let decoder = JSONDecoder()
    
    var defects: [Defect]!
    var stations: [Station]!
    var aircraft: [Aircraft]!
    var chapters: [Chapter]!
    var sections = [DefectSection]()
    
    static let instance = Repository()
    
    private init() {
        loadStations()
        loadAircraft()
        loadChapters()
        loadDefects()
        organizeDefectsToSections()
    }
    
    private func loadStations() {
        let path = Bundle.main.path(forResource: "sta", ofType: "json")
        let jsonString = try! String(contentsOfFile: path!, encoding: .utf8)
        let jsonData: Data = jsonString.data(using: .utf8)!
        stations = try! decoder.decode([Station].self, from: jsonData)
        print(stations.count)
    }
    
    private func loadAircraft() {
        let path = Bundle.main.path(forResource: "ac", ofType: "json")
        let jsonString = try! String(contentsOfFile: path!, encoding: .utf8)
        let jsonData: Data = jsonString.data(using: .utf8)!
        aircraft = try! decoder.decode([Aircraft].self, from: jsonData)
        print(aircraft.count)
    }
    
    private func loadChapters() {
        let path = Bundle.main.path(forResource: "ata", ofType: "json")
        let jsonString = try! String(contentsOfFile: path!, encoding: .utf8)
        let jsonData: Data = jsonString.data(using: .utf8)!
        chapters = try! decoder.decode([Chapter].self, from: jsonData)
        print(chapters.count)
    }
    
    private func loadDefects() {
        let path = Bundle.main.path(forResource: "defects", ofType: "json")
        let jsonString = try! String(contentsOfFile: path!, encoding: .utf8)
        let jsonData: Data = jsonString.data(using: .utf8)!
        defects = try! decoder.decode([Defect].self, from: jsonData)
        print(defects.count)
    }
    
    func organizeDefectsToSections() {
        for defect in defects {
            if let index = sections.firstIndex(where: { $0.title == defect.defectDate.headerStyle() }) {
                sections[index].defects.append(defect)
            } else {
                sections.append(DefectSection(date: defect.defectDate, defects: [defect]))
            }
        }
    }
}
