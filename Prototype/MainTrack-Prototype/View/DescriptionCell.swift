//
//  DescriptionCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    private let controller = DefectController.shared
    public let textView = PlaceholderTextView(placeholder: "Description of defect")
    private let label = MultilineLabel()
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: "ID")
        configureText()
        addObservers()
        setupForMode()
    }
    
    private func configureText() {
        if let defect = controller.defect {
            textView.text = defect.description
            textView.textColor = .black
            label.text = defect.description
        }
    }
    
    private func addObservers() {
        addObserver(action: #selector(onChangeMode), name: .changeMode)
        addObserver(action: #selector(onDismissKeyboard), name: .dismissKeyboard)
    }
    
    @objc func onDismissKeyboard() {
        textView.resignFirstResponder()
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
        textView.removeFromSuperview()
        contentView.addSubview(label)
        label.pin(to: contentView, horizPadding: .halfPadding, vertPadding: .padding)
    }
    
    private func setEditView() {
        label.removeFromSuperview()
        contentView.addSubview(textView)
        textView.pin(to: contentView, horizPadding: .halfPadding, vertPadding: .padding)
    }
}
