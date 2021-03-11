//
//  ViewDetailCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class ViewDetailCell: UITableViewCell {
    
    let stationLabel = UILabel()
    let aircraftLabel = UILabel()
    let chapterLabel = UILabel()
    let subchapterLabel = UILabel()
    
    var defect: Defect! {
        didSet {
            stationLabel.text = "Station: \(defect.sta)"
            aircraftLabel.text = "Aircraft: \(defect.ac)"
            chapterLabel.text = "Ata Chapter: \(String(defect.ata4.dropLast(2)))"
            subchapterLabel.text = "Ata Subchapter: \(defect.ata4)"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stationLabel)
        contentView.addSubview(aircraftLabel)
        contentView.addSubview(chapterLabel)
        contentView.addSubview(subchapterLabel)
        
        stationLabel.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            paddingTop: .halfPadding,
            paddingLeft: .padding
        )
        
        aircraftLabel.anchor(
            top: stationLabel.bottomAnchor,
            left: contentView.leftAnchor,
            paddingTop: .halfPadding,
            paddingLeft: .padding
        )
        
        chapterLabel.anchor(
            top: aircraftLabel.bottomAnchor,
            left: contentView.leftAnchor,
            paddingTop: .halfPadding,
            paddingLeft: .padding
        )
        
        subchapterLabel.anchor(
            top: chapterLabel.bottomAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            paddingTop: .halfPadding,
            paddingLeft: .padding,
            paddingBottom: .halfPadding
        )
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
