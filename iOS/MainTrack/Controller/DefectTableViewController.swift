//
//  DefectTableViewController.swift
//  MainTrack
//
//  Created by Clay Suttner on 3/2/21.
//

import UIKit

class DefectTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Defects"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIButton())
    }
    
}
