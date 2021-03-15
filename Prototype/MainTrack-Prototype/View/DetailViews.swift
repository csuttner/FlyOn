//
//  DetailSections.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

class DetailViews {
    
    private lazy var staCell = DetailCell(attribute: .sta)
    private lazy var acCell = DetailCell(attribute: .ac)
    private lazy var ataCell = DetailCell(attribute: .ata4)
    private lazy var descCell = DescriptionCell()
    public lazy var spacerCell = SpacerCell()
    
    struct Section {
        let title: String
        let cells: [ScrollableCell]
    }
    
    lazy var sections = [
        Section(title: "Details", cells: [
            staCell,
            acCell,
            ataCell
        ]),
        Section(title: "Description", cells: [
            descCell
        ]),
        Section(title: "", cells: [spacerCell])
    ]
    
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
