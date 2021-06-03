//
//  NewDefectViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 6/3/21.
//

import UIKit

class NewDefectViewController: UITableViewController {
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationController()
    }
    
    private func configureNavigationController() {
        searchController.automaticallyShowsCancelButton = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
