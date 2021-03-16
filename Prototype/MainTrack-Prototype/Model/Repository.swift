//
//  DefectDatabase.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/8/21.
//

import Foundation

class Repository {
    
    var defects: [Defect]!
    var stations: [Station]!
    var aircraft: [Aircraft]!
    var chapters: [Chapter]!
    var sections = [DefectSection]()
    
    static let shared = Repository()
    
    public lazy var attributeDataDict: [DefectAttribute : [Any]] = [
        .sta : stations,
        .ac : aircraft,
        .ata4 : chapters
    ]
    
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
        stations = try! JSONDecoder().decode([Station].self, from: jsonData)
    }
    
    private func loadAircraft() {
        let path = Bundle.main.path(forResource: "ac", ofType: "json")
        let jsonString = try! String(contentsOfFile: path!, encoding: .utf8)
        let jsonData: Data = jsonString.data(using: .utf8)!
        aircraft = try! JSONDecoder().decode([Aircraft].self, from: jsonData)
    }
    
    private func loadChapters() {
        let path = Bundle.main.path(forResource: "ata", ofType: "json")
        let jsonString = try! String(contentsOfFile: path!, encoding: .utf8)
        let jsonData: Data = jsonString.data(using: .utf8)!
        chapters = try! JSONDecoder().decode([Chapter].self, from: jsonData)
    }
    
    private func loadDefects() {
        let path = Bundle.main.path(forResource: "defects", ofType: "json")
        let jsonString = try! String(contentsOfFile: path!, encoding: .utf8)
        let jsonData: Data = jsonString.data(using: .utf8)!
        defects = try! JSONDecoder().decode([Defect].self, from: jsonData)
    }
    
    private func organizeDefectsToSections() {
        for defect in defects {
            addDefect(defect)
        }
    }
    
    public func addDefect(_ defect: Defect) {
        if let index = sections.firstIndex(where: { $0.title == defect.defectDate.headerStyle() }) {
            sections[index].defects.append(defect)
            sections[index].defects.sort { (a, b) -> Bool in
                return a.defectDate >= b.defectDate
            }
        } else {
            sections.append(DefectSection(date: defect.defectDate, defects: [defect]))
        }
        sections.sort { (a, b) -> Bool in
            a.date >= b.date
        }
    }

    public func matches(for attribute: DefectAttribute, _ searchText: String) -> [String] {
        let strings = stringRepresentations(for: attribute)
        return strings.compactMap {
            $0.lowercased().contains(searchText.lowercased()) ? $0 : nil
        }
    }
    
    private func stringRepresentations(for attribute: DefectAttribute) -> [String] {
        let strings: [String]
        switch attribute {
        case .sta:
            strings = stations.map({ $0.sta })
        case .ac:
            strings = aircraft.map({ $0.ac })
        case .ata4:
            strings = chapters.flatMap {
                $0.subchapters
            }.map {
                String($0.ata4) + " - " + $0.subchapter_name
            }
        }
        return strings
    }
    
}
