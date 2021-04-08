//
//  EmptyCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/14/21.
//

import UIKit

class SpacerCell: ScrollableCell {
    private let label = MultilineLabel()
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: "ID")
        backgroundColor = .systemGray6
        contentView.addSubview(label)
        label.pin(to: contentView)
    }
    
    func addSpace() {
        label.text = String(repeating: "\n", count: 30)
        NotificationCenter.default.post(name: .updateTable, object: nil)
    }
    
    func removeSpace() {
        label.text = nil
        NotificationCenter.default.post(name: .updateTable, object: nil)
    }
}
