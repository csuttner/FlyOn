//
//  SectionHeader.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 4/11/21.
//

import UIKit

class SectionHeader: UITableViewHeaderFooterView {
    @IBOutlet override var textLabel: UILabel? {
        get { return _textLabel }
        set { _textLabel = newValue }
    }
    
    private var _textLabel: UILabel?
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static let reuseIdentifier = String(describing: self)
}
