//
//  EditDescriptionCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class EditDescriptionCell: UITableViewCell, UITextViewDelegate {
    
    var defect: Defect? {
        didSet {
            if let defect = defect {
                textField.text = defect.description
            }
        }
    }
    
    let textField = UITextView()
    
    var tableDelegate: UpdatableTableDelegate!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textField.isScrollEnabled = false
        textField.font = .preferredFont(forTextStyle: .body)
        textField.layer.cornerRadius = 8
        textField.delegate = self
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        contentView.addSubview(textField)
        textField.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingTop: .halfPadding,
            paddingLeft: .padding,
            paddingBottom: .halfPadding,
            paddingRight: .padding
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardNeedsDismissing), name: .keyboardNeedsDismissing, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        tableDelegate.updateTable()
    }
    
    @objc func onKeyboardNeedsDismissing() {
        textField.resignFirstResponder()
    }
}
