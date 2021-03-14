//
//  DetailCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

class DetailCell: UITableViewCell {
    
    private let controller = DefectController.shared
    public var searchBar: DetailSearchBar!
    private let label = UILabel()

    struct Detail {
        let name: String
        let value: String?
    }
    
    lazy var detailDict: [DefectAttribute: Detail] = [
        .sta : Detail(name: "Station", value: controller.defect?.sta),
        .ac : Detail(name: "Aircraft", value: controller.defect?.ac),
        .ata4 : Detail(name: "Ata Subchapter", value: controller.defect?.ata4)
    ]
    
    var detail: Detail!
    
    convenience init(attribute: DefectAttribute) {
        self.init(style: .default, reuseIdentifier: "ID")
        searchBar = DetailSearchBar(placeholder: detailDict[attribute]!.name)
        searchBar.text = detailDict[attribute]!.value
        label.text = detailDict[attribute]!.value
        addObserver(action: #selector(onChangeMode), name: .changeMode)
        addObserver(action: #selector(onDismissKeyboard), name: .dismissKeyboard)
        setupForMode()
    }
    
    @objc func onDismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    @objc func onChangeMode() {
        setupForMode()
        NotificationCenter.default.post(name: .updateTable, object: nil)
    }
    
    private func setupForMode() {
        if controller.mode == .view {
            setReadView()
        } else {
            setEditView()
        }
    }
    
    private func setReadView() {
        searchBar.removeFromSuperview()
        contentView.addSubview(label)
        label.pin(to: contentView, horizPadding: .halfPadding, vertPadding: .padding)
    }
    
    private func setEditView() {
        label.removeFromSuperview()
        contentView.addSubview(searchBar)
        searchBar.pin(to: contentView, horizPadding: .halfPadding, vertPadding: .padding)
    }
    
}
