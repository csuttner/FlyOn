//
//  DefectViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class DefectViewController: UITableViewController {
    
    let repository = Repository.shared
    let controller = DefectController.shared
    
    lazy var newDefectButton = ActionButton(title: "New Defect", color: .systemGreen, target: self, action: #selector(onNewDefectButtonTapped))
    lazy var profileItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: self, action: #selector(onProfileButtonTapped))

    override func viewDidLoad() {
        super.viewDidLoad()
        formatView()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationController()
        addToolBarItems()
        loadDefectsForRole()
    }
    
    private func loadDefectsForRole() {
        if userData.role == .analyst {
            repository.loadAllDefects { self.tableView.reloadData() }
        } else {
            repository.loadDefects(for: userData.email) { self.tableView.reloadData() }
        }
    }
    
    private func formatView() {
        title = "Defects"
        view.backgroundColor = .systemGray6
    }
    
    private func configureTableView() {
        tableView.register(DefectCell.self, forCellReuseIdentifier: "ID")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func configureNavigationController() {
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = profileItem
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        
        if userData.role == .analyst {
            navigationController?.isToolbarHidden = true
        } else {
            navigationController?.isToolbarHidden = false
        }
    }
    
    private func addToolBarItems() {
        toolbarItems = [
            UIBarButtonItem(systemItem: .flexibleSpace),
            UIBarButtonItem(customView: newDefectButton),
            UIBarButtonItem(systemItem: .flexibleSpace)
        ]
    }
    
    @objc func onNewDefectButtonTapped() {
        controller.defect = nil
        controller.mode = .edit
        navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
    @objc func onProfileButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - Table View

// UITableViewDataSource
extension DefectViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return repository.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.sections[section].defects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID") as! DefectCell
        cell.defect = repository.sections[indexPath.section].defects[indexPath.row]
        return cell
    }
    
}

// UITableViewDelegate
extension DefectViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionHeaderView(title: repository.sections[section].title)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller.defect = repository.sections[indexPath.section].defects[indexPath.row]
        controller.mode = .view
        navigationController!.pushViewController(DetailViewController(), animated: true)
    }
    
}
