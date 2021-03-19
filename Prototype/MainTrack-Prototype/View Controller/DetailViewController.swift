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
    lazy var resolveButton = ActionButton(title: "Close", color: .systemGreen, target: self, action: #selector(onResolveButtonTapped))
    lazy var archiveButton = ActionButton(title: "Archive", color: .systemGray, target: self, action: #selector(onArchiveButtonTapped))
    
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
    
    private func configureTitle() {
        if let defect = controller.defect {
            title = controller.mode == .edit ? "Edit \(defect.id)" : "Defect \(defect.id)"
        } else {
            title = "New Defect"
        }
    }
    
    private func addGestureRecognizers() {
        let navBarTap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        navigationController?.navigationBar.addGestureRecognizer(navBarTap)
        view.addGestureRecognizer(viewTap)
    }
    
    private func addObservers() {
        addObserver(action: #selector(onChangeMode), name: .changeMode)
        addObserver(action: #selector(onUpdateTable), name: .updateTable)
    }
    
}

// MARK: - Table View
extension DetailViewController {
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return detailViews.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailViews.sections[section].cells.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionHeaderView(title: detailViews.sections[section].title)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailViews.sections[indexPath.section].cells[indexPath.row]
        cell.scrollDelegate = self
        return cell
    }
    
}

// MARK: Scrolling Behavior
extension DetailViewController: CellScrollDelegate {
    
    func scrollTo(indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
}

// MARK: - Selectors
extension DetailViewController {
    
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
    
    @objc func onResolveButtonTapped() {
        controller.defect?.resolved = true
        updateDefect()
        configureToolbarItems()
    }
    
    @objc func onArchiveButtonTapped() {
        archiveDefect()
    }
    
    @objc func onSubmitButtonTapped() {
        scrollTo(indexPath: IndexPath(row: 0, section: 0))
        if controller.defect == nil {
            createDefect()
        } else {
            updateDefect()
        }
    }
    
}

// MARK: Record Modification
extension DetailViewController {
    
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
    
    private func archiveDefect() {
        apiClient.archive(controller.defect!)
        presentReturningAlert(title: "Defect \(controller.defect!.id) archived")
    }
    
}

// MARK: Toolbar Configuration
extension DetailViewController {
    
    private func configureToolbarItems() {
        if userData.role == .analyst {
            setToolbarItems(getAnalystToolbarItems(), animated: true)
        } else {
            setToolbarItems(getTechnicianToolbarItems(), animated: true)
        }
    }
    
    private func getAnalystToolbarItems() -> [UIBarButtonItem] {
        if controller.defect!.resolved {
            return getSpacedButtonItems(with: [archiveButton])
        } else {
            return getSpacedButtonItems(with: [resolveButton])
        }
    }
    
    private func getTechnicianToolbarItems() -> [UIBarButtonItem] {
        if controller.mode == .edit {
            return getSpacedButtonItems(with: [cancelButton, submitButton])
        } else {
            return getSpacedButtonItems(with: [editButton])
        }
    }
    
}
