//
//  DetailCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit
import DropDown

class DetailCell: ScrollableCell {
    
    private let reposistory = Repository.shared
    private let controller = DefectController.shared
    
    public var searchBar: DetailSearchBar!
    private let label = UILabel()
    private let dropDown = DropDown()
    private let anchorView = UIView()
    
    class Detail {
        let name: String
        var value: () -> String?
        
        init(name: String, value: @escaping() -> String?) {
            self.name = name
            self.value = value
        }
    }
    
    lazy var detailDict: [DefectAttribute: Detail] = [
        .sta : Detail(name: "Station", value: { return self.controller.defect?.sta }),
        .ac : Detail(name: "Aircraft", value: { return self.controller.defect?.ac }),
        .ata4 : Detail(name: "Ata Subchapter", value: { return self.controller.defect?.ata4 })
    ]
    
    private var attribute: DefectAttribute!
    
    convenience init(attribute: DefectAttribute) {
        self.init(style: .default, reuseIdentifier: "ID")
        self.attribute = attribute
        configureViews()
        addObservers()
        setupDropDown()
        setupForMode()
    }
    
    private func setupDropDown() {
        dropDown.anchorView = anchorView
        dropDown.selectionAction = { index, item in
            self.searchBar.text = item
        }
    }
    
    private func configureViews() {
        searchBar = DetailSearchBar(placeholder: detailDict[attribute]!.name)
        searchBar.delegate = self
        configureText()
        setupAnchorView()
    }
    
    private func setupAnchorView() {
        contentView.addSubview(anchorView)
        anchorView.anchor(
            top: contentView.bottomAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor
        )
    }
    
    private func configureText() {
        label.text = detailDict[attribute]!.value()
        searchBar.text = detailDict[attribute]!.value()
    }
    
    private func addObservers() {
        addObserver(action: #selector(onChangeMode), name: .changeMode)
        addObserver(action: #selector(onDismissKeyboard), name: .dismissKeyboard)
    }
    
    @objc func onDismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    @objc func onChangeMode() {
        setupForMode()
        configureText()
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

extension DetailCell: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let row = DefectAttribute.allCases.firstIndex(of: attribute)!
        scrollDelegate.scrollTo(indexPath: IndexPath(row: row, section: 0))
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dropDown.dataSource = reposistory.matches(for: attribute, searchText)
        dropDown.show()
    }
}
