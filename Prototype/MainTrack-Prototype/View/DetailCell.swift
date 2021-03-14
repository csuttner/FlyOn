//
//  DetailCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

class DetailCell: UITableViewCell {
    
    private var defect: Defect?
    public var searchBar: DetailSearchBar!
    private let label = UILabel()
    
    private var mode: DetailMode! {
        didSet {
            setupForMode()
        }
    }

    struct Detail {
        let name: String
        let value: String?
    }
    
    lazy var detailDict: [DefectDetail: Detail] = [
        .sta : Detail(name: "Station", value: defect?.sta),
        .ac : Detail(name: "Aircraft", value: defect?.ac),
        .ata4 : Detail(name: "Ata Subchapter", value: defect?.ata4)
    ]
    
    var detail: Detail!
    
    convenience init(defect: Defect?, detail: DefectDetail, mode: DetailMode) {
        self.init(style: .default, reuseIdentifier: "ID")
        self.defect = defect
        self.mode = mode
        searchBar = DetailSearchBar(placeholder: detailDict[detail]!.name)
        searchBar.text = detailDict[detail]!.value
        label.text = detailDict[detail]!.value
        addObserver(action: #selector(onChangeMode), name: .changeMode)
        addObserver(action: #selector(onDismissKeyboard), name: .dismissKeyboard)
        setupForMode()
    }
    
    @objc func onDismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    @objc func onChangeMode() {
        if mode == .view {
            mode = .edit
        } else {
            mode = .view
        }
    }
    
    private func setupForMode() {
        if mode == .view {
            setReadView()
        } else {
            setEditView()
        }
    }
    
    private func setReadView() {
        searchBar.removeFromSuperview()
        contentView.addSubview(label)
        label.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingTop: .halfPadding,
            paddingLeft: .padding,
            paddingBottom: .halfPadding,
            paddingRight: .padding
        )
    }
    
    private func setEditView() {
        label.removeFromSuperview()
        contentView.addSubview(searchBar)
        searchBar.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingTop: .halfPadding,
            paddingLeft: .padding,
            paddingBottom: .halfPadding,
            paddingRight: .padding
        )
    }
    
}
