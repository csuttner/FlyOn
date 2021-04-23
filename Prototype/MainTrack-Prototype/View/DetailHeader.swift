//
//  DetailHeader.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 4/22/21.
//

import UIKit

class DetailHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var completedIndicator: UIImageView!
    
    @IBOutlet override var textLabel: UILabel? {
        get { return _textLabel }
        set { _textLabel = newValue }
    }
    
    private var _textLabel: UILabel?
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static let identifier = String(describing: self)
}
