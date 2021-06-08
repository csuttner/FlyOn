//
//  HomeViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 5/25/21.
//

import UIKit

class HomeViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationController()
        configureTableView()
    }

    private func configureNavigationController() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
    }
    
    private func configureTableView() {
        tableView.register(SectionHeader.nib, forHeaderFooterViewReuseIdentifier: SectionHeader.identifier)
        tableView.tableFooterView = UIView(frame: .zero)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeader.identifier) as! SectionHeader
        header.textLabel?.text = "My Work"
        return header
    }
}
