//
//  DetailSearchBar.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/12/21.
//

import UIKit

class DetailSearchBar: UISearchBar {
    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
        searchBarStyle = .minimal
    }
}
