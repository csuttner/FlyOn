//
//  OldDefectViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit
import FirebaseAuth

class DefectViewController: UITableViewController {
    let repository = Repository.shared
//    let controller = DefectController.shared
    
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
        if userData.role == .analyst {
            repository.loadAllDefects { self.tableView.reloadData() }
        } else {
            repository.loadDefects(for: userData.email) { self.tableView.reloadData() }
        }
    }
    
    private func configureNavigationController() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        
        if userData.role == .analyst {
            navigationController?.isToolbarHidden = true
        } else {
            navigationController?.isToolbarHidden = false
            setToolbarItems(getSpacedButtonItems(with: [newDefectButton]), animated: true)
        }
    }
    
    @objc func onNewDefectButtonTapped() {
        let detailViewController = DetailViewController(defect: nil, mode: .edit)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @IBAction func onProfileButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
            repository.clearDefects()
        } catch let error {
            presentBasicAlert(title: "Error signing out", message: error.localizedDescription)
        }
    }

    // MARK: - Table View
    
    private func configureTableView() {
        tableView.register(DefectCell.self)
        tableView.register(SectionHeader.nib, forHeaderFooterViewReuseIdentifier: SectionHeader.reuseIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return repository.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.sections[section].defects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(DefectCell.self)!
        cell.defect = repository.sections[indexPath.section].defects[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeader.reuseIdentifier) as! SectionHeader
        header.textLabel?.text = repository.sections[section].title
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            let indexPath = tableView.indexPathForSelectedRow!
            let defect = repository.sections[indexPath.section].defects[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.defect = defect
            detailViewController.mode = .edit
        }
    }
}
