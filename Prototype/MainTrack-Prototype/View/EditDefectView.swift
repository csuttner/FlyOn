//
//  EditDefectView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

class EditDefectView: UIView {
    
    private let detailsHeader = SectionHeaderView(title: "Details")
    private let descriptionHeader = SectionHeaderView(title: "Description")
    
    private let stationSearch = DetailSearchBar(placeholder: "Station")
    private let aircraftSearch = DetailSearchBar(placeholder: "Aircraft")
    private let chapterSearch = DetailSearchBar(placeholder: "Ata Chapter")
    private let subchapterSearch = DetailSearchBar(placeholder: "Ata Subchapter")
    
    private let descriptionText = PlaceholderTextView(placeholder: "Description")
    
    private lazy var descriptionContainer = ViewContainer<PlaceholderTextView>(
        view: descriptionText,
        paddingLeft: .padding,
        paddingBottom: .halfPadding,
        paddingRight: .padding
    )
    
    private lazy var stack = UIStackView(
        arrangedSubviews: [
            detailsHeader,
            stationSearch,
            aircraftSearch,
            chapterSearch,
            subchapterSearch,
            descriptionHeader,
            descriptionContainer
        ]
    ).withAttributes(spacing: .halfPadding)
    
    public var defect: Defect?
    
    convenience init(_ defect: Defect?) {
        self.init()
        self.defect = defect
        configure(for: defect)
        addSubview(stack)
        stack.pin(to: self)
        backgroundColor = .systemBackground
    }
    
    func configure(for defect: Defect?) {
        if let defect = defect {
            stationSearch.text = defect.sta
            aircraftSearch.text = defect.ac
            chapterSearch.text = String(defect.ata4.dropLast(2))
            subchapterSearch.text = defect.ata4
            descriptionText.text = defect.description
        }
    }
    
}
