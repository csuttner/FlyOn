//
//  NewDefectViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 6/3/21.
//

import UIKit

class NewDefectViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        
        let cancelButton = UIButton()
        cancelButton.setTitle("cancel", for: .normal)
        
        let cancelButtonItem = UIBarButtonItem(customView: cancelButton)
        navigationItem.leftBarButtonItem = cancelButtonItem
        
        let subheadingLabel = UILabel()
        subheadingLabel.text = "Choose an aircraft"
        subheadingLabel.textColor = .systemGray
        
        navigationItem.titleView = subheadingLabel
    }
}
