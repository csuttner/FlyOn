//
//  NewDetailViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

class DetailViewController: UITableViewController {
    
    private var defect: Defect?
    
    private var mode: DetailMode! {
        didSet {
            NotificationCenter.default.post(name: .changeMode, object: nil)
            tableView.beginUpdates()
            tableView.endUpdates()
            setupForMode()
            configureView()
        }
    }
    
    var detailCollection: DetailCollection!
    
    lazy var editButton = ActionButton(title: "Edit", color: .systemBlue, target: self, action: #selector(onEditButtonTapped))
    lazy var cancelButton = ActionButton(title: "Cancel", color: .systemGray, target: self, action: #selector(onCancelButtonTapped))
    lazy var submitButton = ActionButton(title: "Submit", color: .systemGreen, target: self, action: #selector(onSubmitButtonTapped))
    
    convenience init(defect: Defect?, mode: DetailMode) {
        self.init(style: .plain)
        self.defect = defect
        self.mode = mode
        self.detailCollection = DetailCollection(defect: defect, mode: mode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addGestureRecognizers()
        configureView()
        configureTableView()
        setupForMode()
    }
    
    private func addGestureRecognizers() {
        let navBarTap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        navigationController?.navigationBar.addGestureRecognizer(navBarTap)
        view.addGestureRecognizer(viewTap)
    }

    private func configureView() {
        view.backgroundColor = .systemGray6
        if let defect = defect {
            title = mode == .edit ? "Edit \(defect.id)" : "Defect \(defect.id)"
        } else {
            title = "New Defect"
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
    }
    
    private func setupForMode() {
        let toolbarItems: [UIBarButtonItem]
        if mode == .edit {
            toolbarItems = [
                UIBarButtonItem(systemItem: .flexibleSpace),
                UIBarButtonItem(customView: cancelButton),
                UIBarButtonItem(systemItem: .flexibleSpace),
                UIBarButtonItem(customView: submitButton),
                UIBarButtonItem(systemItem: .flexibleSpace)
            ]
        } else {
            toolbarItems = [
                UIBarButtonItem(systemItem: .flexibleSpace),
                UIBarButtonItem(customView: editButton),
                UIBarButtonItem(systemItem: .flexibleSpace)
            ]
        }
        setToolbarItems(toolbarItems, animated: true)
    }
    
    @objc func onTap() {
        NotificationCenter.default.post(name: .dismissKeyboard, object: nil)
    }
    
    @objc func onEditButtonTapped() {
        mode = .edit
    }
    
    @objc func onCancelButtonTapped() {
        mode = .view
    }
    
    @objc func onSubmitButtonTapped() {
        if defect == nil {
            createDefect()
        } else {
            updateDefect()
        }
    }
    
    private func createDefect() {
        do {
            defect = try detailCollection.getNewDefectFromInput()
            try ApiClient.shared.post(defect!)
            presentBasicAlert(title: "Defect \(defect!.id) created")
            mode = .view
        } catch {
            presentBasicAlert(title: "Error creating defect")
        }
    }
    
    private func updateDefect() {
        do {
            try detailCollection.updateDefectFromInput(defect!)
            try ApiClient.shared.put(defect!)
            presentBasicAlert(title: "Defect \(defect!.id) updated")
            mode = .view
        } catch {
            presentBasicAlert(title: "Error updating defect")
        }
    }
    
}

// UITableViewDataSource
extension DetailViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return detailCollection.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailCollection.sections[section].cells.count
    }
    
}

// UITableViewDelegate
extension DetailViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionHeaderView(title: detailCollection.sections[section].title)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return detailCollection.sections[indexPath.section].cells[indexPath.row]
    }
    
}
