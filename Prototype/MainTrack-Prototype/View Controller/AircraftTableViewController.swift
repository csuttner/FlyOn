//
//  AircraftTableViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 6/6/21.
//

import UIKit

class AircraftTableViewController: UITableViewController {
    let repository = Repository.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(AircraftCell.self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.aircraft.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(AircraftCell.self)!
        let aircraft = repository.aircraft[indexPath.row]
        cell.configure(with: AircraftCellViewModel(aircraft: aircraft))
        return cell
    }
}
