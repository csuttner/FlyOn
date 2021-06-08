//
//  ChooseAnAircraftViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 6/3/21.
//

import UIKit

class ChooseAnAircraftViewController: UITableViewController {
    let repository = Repository.shared
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationController()
        configureTableView()
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func configureNavigationController() {
        searchController.automaticallyShowsCancelButton = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EnterDefectDetailsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EnterDefectDetailsSegue" {
            let navigationController = segue.destination as! UINavigationController
            let enterDefectDetailsViewController = navigationController.viewControllers.first! as! EnterDefectDetailsViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let aircraft = repository.aircraft[indexPath.row]
                enterDefectDetailsViewController.viewModel = EnterDefectDetailsViewModel(aircraft: aircraft)
            }
        }
    }
}
