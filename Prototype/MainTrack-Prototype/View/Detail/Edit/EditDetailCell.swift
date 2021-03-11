//
//  EditDetailCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class SearchBar: UISearchBar {
    
    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
        searchBarStyle = .minimal
        searchTextField.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingLeft: .halfPadding,
            paddingRight: .halfPadding
        )
        anchor(
            height: searchTextField.intrinsicContentSize.height
        )
    }
    
}

class EditDetailCell: UITableViewCell {
    
    var defect: Defect? {
        didSet {
            if let defect = defect {
                stationSearch.text = defect.sta
                aircraftSearch.text = defect.ac
                chapterSearch.text = String(defect.ata4.dropLast(2))
                subchapterSearch.text = defect.ata4
            }
        }
    }
    
    let stationSearch = SearchBar(placeholder: "Station")
    let aircraftSearch = SearchBar(placeholder: "Aircraft")
    let chapterSearch = SearchBar(placeholder: "Ata Chapter")
    let subchapterSearch = SearchBar(placeholder: "Ata Subchapter")
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = .halfPadding
        stack.addArrangedSubview(stationSearch)
        stack.addArrangedSubview(aircraftSearch)
        stack.addArrangedSubview(chapterSearch)
        stack.addArrangedSubview(subchapterSearch)
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.addSubview(stack)
        stack.pin(to: contentView, padding: .halfPadding)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardNeedsDismissing), name: .keyboardNeedsDismissing, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onKeyboardNeedsDismissing() {
        stationSearch.resignFirstResponder()
        aircraftSearch.resignFirstResponder()
        chapterSearch.resignFirstResponder()
        subchapterSearch.resignFirstResponder()
    }
    
}
