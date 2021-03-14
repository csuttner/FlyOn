//
//  DescriptionCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    private var defect: Defect?
    public let textView = PlaceholderTextView(placeholder: "Description of defect")
    private let label = MultilineLabel()
    
    private var mode: DetailMode! {
        didSet {
            setupForMode()
        }
    }
    
    convenience init(defect: Defect?, mode: DetailMode) {
        self.init(style: .default, reuseIdentifier: "ID")
        self.defect = defect
        self.mode = mode
        if let defect = defect {
            textView.text = defect.description
            textView.textColor = .black
            label.text = defect.description
        }
        addObserver(action: #selector(onChangeMode), name: .changeMode)
        addObserver(action: #selector(onDismissKeyboard), name: .dismissKeyboard)
        setupForMode()
    }
    
    @objc func onDismissKeyboard() {
        textView.resignFirstResponder()
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
        textView.removeFromSuperview()
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
        contentView.addSubview(textView)
        textView.anchor(
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
