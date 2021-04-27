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
    
    public static let shared = Repository()
    
    private let apiClient = ApiClient.shared
    
    public enum DefectAttribute {
        case sta
        case ac
        case ata4
    }
    
    public lazy var attributeDataDict: [DefectAttribute : [Any]] = [
        .sta : stations,
        .ac : aircraft,
        .ata4 : chapters
    ]
    
    private init() {
        loadStations()
        loadAircraft()
        loadChapters()
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
    
    public func loadAllDefects(completion: @escaping() -> Void) {
        apiClient.getAllDefects { (defects) in
            self.sections = []
            self.defects = defects
            self.organizeDefectsToSections()
            completion()
        }
    }
    
    public func loadDefects(for email: String, completion: @escaping() -> Void) {
        apiClient.getDefects(for: email) { (defects) in
            self.sections = []
            self.defects = defects
            self.organizeDefectsToSections()
            completion()
        }
    }
    
    private func organizeDefectsToSections() {
        for defect in defects {
            addDefectToSections(defect)
        }
    }
    
    public func addDefectToSections(_ defect: Defect) {
        if let index = sections.firstIndex(where: { $0.title == defect.defectDate.getDate()!.headerStyle() }) {
            sections[index].defects.append(defect)
            sections[index].defects.sort { $0.defectDate.getDate()! >= $1.defectDate.getDate()! }
        } else {
            sections.append(DefectSection(date: defect.defectDate.getDate()!, defects: [defect]))
        }
        sections.sort { $0.date.getDate()! >= $1.date.getDate()! }
    }

    public func clearDefects() {
        sections = []
    }
    
    func stringRepresentations(for attribute: DefectAttribute) -> [String] {
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
