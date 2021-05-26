//
//  HomeViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 5/25/21.
//

import UIKit

class HomeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationController()
    }

    private func configureNavigationController() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

}
