//
//  OldDefectViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit
import FirebaseAuth

class FeedViewController: UITableViewController {
    let repository = Repository.shared
    
    lazy var newDefectButton = ActionButton(title: "New Defect", color: .systemGreen, target: self, action: #selector(onNewDefectButtonTapped))

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationController()
        loadDefectsForRole()
    }
    
    private func loadDefectsForRole() {
        repository.loadAllDefects { self.tableView.reloadData() }
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.isToolbarHidden = false
        setToolbarItems(getSpacedButtonItems(with: [newDefectButton]), animated: true)
    }
    
    @objc func onNewDefectButtonTapped() {
        performSegue(withIdentifier: "ShowDetailSegue", sender: self)
    }

    // MARK: - Table View
    
    private func configureTableView() {
        tableView.register(FeedCell.self)
        tableView.register(SectionHeader.nib, forHeaderFooterViewReuseIdentifier: SectionHeader.identifier)
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return repository.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.sections[section].defects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(FeedCell.self)!
        let defect = repository.sections[indexPath.section].defects[indexPath.row]
        
        cell.configure(with: FeedCellViewModel(defect: defect))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeader.identifier) as! SectionHeader
        header.textLabel?.text = repository.sections[section].title
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            let detailViewController = segue.destination as! DetailViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let defect = repository.sections[indexPath.section].defects[indexPath.row]
                detailViewController.viewModel = DetailViewModel(defect: defect)
                detailViewController.readOnly = true
            } else {
                detailViewController.viewModel = DetailViewModel(defect: nil)
                detailViewController.readOnly = false
            }
        }
    }
}
