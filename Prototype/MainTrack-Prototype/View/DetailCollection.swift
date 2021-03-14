//
//  DetailSections.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

class DetailCollection {
    
    public var defect: Defect?
    public var mode: DetailMode!
    
    private lazy var staCell = DetailCell(defect: defect, detail: .sta, mode: mode)
    private lazy var acCell = DetailCell(defect: defect, detail: .ac, mode: mode)
    private lazy var ataCell = DetailCell(defect: defect, detail: .ata4, mode: mode)
    private lazy var descCell = DescriptionCell(defect: defect, mode: mode)
    
    struct Section {
        let title: String
        let cells: [UITableViewCell]
    }
    
    lazy var sections = [
        Section(title: "Details", cells: [
            staCell,
            acCell,
            ataCell
        ]),
        Section(title: "Description", cells: [
            descCell
        ])
    ]
    
    init(defect: Defect?, mode: DetailMode) {
        self.defect = defect
        self.mode = mode
    }
    
    public func getNewDefectFromInput() throws -> Defect {
        guard let sta = staCell.searchBar.text, !sta.isEmpty,
              let ac = acCell.searchBar.text, !ac.isEmpty,
              let ata4 = ataCell.searchBar.text, !ata4.isEmpty,
              let description = descCell.textView.text, !description.isEmpty
        else {
            throw ValidationError.missingData
        }
        return Defect(sta, ac, ata4, description)
    }
    
    public func updateDefectFromInput(_ defect: Defect) throws {
        guard let sta = staCell.searchBar.text, !sta.isEmpty,
              let ac = acCell.searchBar.text, !ac.isEmpty,
              let ata4 = ataCell.searchBar.text, !ata4.isEmpty,
              let description = descCell.textView.text, !description.isEmpty
        else {
            throw ValidationError.missingData
        }
        defect.sta = sta
        defect.ac = ac
        defect.ata4 = ata4
        defect.description = description
    }
    
}
