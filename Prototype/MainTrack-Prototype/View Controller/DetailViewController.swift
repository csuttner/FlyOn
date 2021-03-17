//
//  NewDetailViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

class DetailViewController: UITableViewController {
    
    private let repository = Repository.shared
    private let controller = DefectController.shared
    private let apiClient = ApiClient.shared
    
    let detailViews = DetailViews()
    
    lazy var editButton = ActionButton(title: "Edit", color: .systemBlue, target: self, action: #selector(onEditButtonTapped))
    lazy var cancelButton = ActionButton(title: "Cancel", color: .systemGray, target: self, action: #selector(onCancelButtonTapped))
    lazy var submitButton = ActionButton(title: "Submit", color: .systemGreen, target: self, action: #selector(onSubmitButtonTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        configureTableView()
        addGestureRecognizers()
        addObservers()
        onChangeMode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.isToolbarHidden = false
    }
    
    private func addObservers() {
        addObserver(action: #selector(onChangeMode), name: .changeMode)
        addObserver(action: #selector(onUpdateTable), name: .updateTable)
    }
    
    private func addGestureRecognizers() {
        let navBarTap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        navigationController?.navigationBar.addGestureRecognizer(navBarTap)
        view.addGestureRecognizer(viewTap)
    }

    private func configureTitle() {
        if let defect = controller.defect {
            title = controller.mode == .edit ? "Edit \(defect.id)" : "Defect \(defect.id)"
        } else {
            title = "New Defect"
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    
    private func configureToolbarItems() {
        let toolbarItems: [UIBarButtonItem]
        if controller.mode == .edit {
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
    
    @objc func onUpdateTable() {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    @objc func onChangeMode() {
        configureTitle()
        configureToolbarItems()
    }
    
    @objc func onTap() {
        NotificationCenter.default.post(name: .dismissKeyboard, object: nil)
    }
    
    @objc func onEditButtonTapped() {
        controller.mode = .edit
        scrollTo(indexPath: IndexPath(row: 0, section: 0))
    }
    
    @objc func onCancelButtonTapped() {
        controller.mode = .view
        scrollTo(indexPath: IndexPath(row: 0, section: 0))
    }
    
    @objc func onSubmitButtonTapped() {
        scrollTo(indexPath: IndexPath(row: 0, section: 0))
        if controller.defect == nil {
            createDefect()
        } else {
            updateDefect()
        }
    }
    
    private func createDefect() {
        do {
            controller.defect = try detailViews.getNewDefectFromInput()
            apiClient.post(controller.defect!)
            repository.addDefectToSections(controller.defect!)
            presentBasicAlert(title: "Defect \(controller.defect!.id) created")
            controller.mode = .view
        } catch {
            presentBasicAlert(title: "Error creating defect")
        }
    }
    
    private func updateDefect() {
        do {
            try detailViews.updateDefectFromInput(controller.defect!)
            apiClient.put(controller.defect!)
            presentBasicAlert(title: "Defect \(controller.defect!.id) updated")
            controller.mode = .view
        } catch {
            presentBasicAlert(title: "Error updating defect")
        }
    }
    
}

// MARK: - Table View

// UITableViewDataSource
extension DetailViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return detailViews.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailViews.sections[section].cells.count
    }
    
}

// UITableViewDelegate
extension DetailViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionHeaderView(title: detailViews.sections[section].title)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailViews.sections[indexPath.section].cells[indexPath.row]
        cell.scrollDelegate = self
        return cell
    }
    
}

extension DetailViewController: CellScrollDelegate {
    
    func scrollTo(indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
}
