//
//  StationTableViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 6/6/21.
//

import UIKit

class StationTableViewController: UITableViewController {
    let repository = Repository.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(StationCell.self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(StationCell.self)!
        let station = repository.stations[indexPath.row]
        cell.configure(with: StationCellViewModel(station: station))
        return cell
    }
}

