//
//  ReadDefectView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

class ReadDefectView: UIView {
    
    private let detailsHeader = SectionHeaderView(title: "Details")
    private let descriptionHeader = SectionHeaderView(title: "Description")
    
    private let stationContainer = ViewContainer<UILabel>(paddingLeft: .padding, paddingRight: .padding)
    private let aircraftContainer = ViewContainer<UILabel>(paddingLeft: .padding, paddingRight: .padding)
    private let chapterContainer = ViewContainer<UILabel>(paddingLeft: .padding, paddingRight: .padding)
    private let subchapterContainer = ViewContainer<UILabel>(paddingLeft: .padding, paddingRight: .padding)
    private let descriptionContainer = ViewContainer<UILabel>(paddingLeft: .padding, paddingBottom: .halfPadding, paddingRight: .padding)

    private lazy var stack = UIStackView(
        arrangedSubviews: [
            detailsHeader,
            stationContainer,
            aircraftContainer,
            chapterContainer,
            subchapterContainer,
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
        backgroundColor = .systemBlue
    }
    
    func configure(for: Defect?) {
        if let defect = defect {
            stationContainer.view.text = "Station: \(defect.sta)"
            aircraftContainer.view.text = "Aircraft: \(defect.ac)"
            chapterContainer.view.text = "Ata Chapter: \(String(defect.ata4.dropLast(2)))"
            subchapterContainer.view.text = "Ata Subchapter: \(defect.ata4)"
            descriptionContainer.view.text = defect.description
        }
    }
    
}
