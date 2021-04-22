//
//  NewDetailViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit
import DropDown

class DetailViewController: UITableViewController {
    private let repository = Repository.shared
    private let apiClient = ApiClient.shared
    
    var defect: Defect?
    var mode: Mode!
    
    public enum Mode {
        case edit
        case read
    }
    
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var aircraftLabel: UILabel!
    @IBOutlet weak var subchapterLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet var readViews: [UIView]!
    @IBOutlet var readConstraints: [NSLayoutConstraint]!
    
    @IBOutlet weak var stationSearch: UISearchBar!
    @IBOutlet weak var aircraftSearch: UISearchBar!
    @IBOutlet weak var subchapterSearch: UISearchBar!
    @IBOutlet weak var descriptionText: DescriptionTextView!
    
    @IBOutlet var editViews: [UIView]!
    @IBOutlet var editConstraints: [NSLayoutConstraint]!
    
    @IBOutlet weak var stationAnchor: UIView!
    @IBOutlet weak var aircraftAnchor: UIView!
    @IBOutlet weak var subchapterAnchor: UIView!
    
    private lazy var stationDropDown = DropDown(anchorView: stationAnchor)
    private lazy var aircraftDropDown = DropDown(anchorView: aircraftAnchor)
    private lazy var subchapterDropDown = DropDown(anchorView: subchapterAnchor)
    
    lazy var editButton = ActionButton(title: "Edit", color: .systemBlue, target: self, action: #selector(onEditButtonTapped))
    lazy var cancelButton = ActionButton(title: "Cancel", color: .systemGray, target: self, action: #selector(onCancelButtonTapped))
    lazy var submitButton = ActionButton(title: "Submit", color: .systemGreen, target: self, action: #selector(onSubmitButtonTapped))
    lazy var resolveButton = ActionButton(title: "Close", color: .systemGreen, target: self, action: #selector(onResolveButtonTapped))
    lazy var archiveButton = ActionButton(title: "Archive", color: .systemGray, target: self, action: #selector(onArchiveButtonTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropDowns()
        onChangeMode()
        tableView.register(SectionHeader.nib, forHeaderFooterViewReuseIdentifier: SectionHeader.identifier)
    }
    
    private func setupDropDowns() {
        stationDropDown.selectionAction = { [weak self] in self?.stationSearch.text = $1 }
        aircraftDropDown.selectionAction = { [weak self] in self?.aircraftSearch.text = $1 }
        subchapterDropDown.selectionAction = { [weak self] in self?.subchapterSearch.text = $1 }
    }
    
    private func onChangeMode() {
        configureForDefect()
        configureTitle()
        configureToolbarItems()
        configureModeViews()
    }
    
    private func configureTitle() {
        if let defect = defect {
            title = mode == .edit ? "Edit \(defect.id)" : "Defect \(defect.id)"
        } else {
            title = "New Defect"
        }
    }
    
    private func configureForDefect() {
        if let defect = defect {
            stationLabel.text = defect.sta
            aircraftLabel.text = defect.ac
            subchapterLabel.text = defect.ata4
            descriptionLabel.text = defect.description
            
            stationSearch.text = defect.sta
            aircraftSearch.text = defect.ac
            subchapterSearch.text = defect.ata4
            descriptionText.text = defect.description
        } else {
            stationLabel.text = ""
            aircraftLabel.text = ""
            subchapterLabel.text = ""
            descriptionLabel.text = ""
        }
    }
    
    private func configureToolbarItems() {
        if userData.role == .pilot {
            setToolbarItems(getPilotToolbarItems(), animated: true)
        } else {
            setToolbarItems(getTechnicianToolbarItems(), animated: true)
        }
    }
    
    private func configureModeViews() {
        if mode == .edit {
            for view in readViews { view.isHidden = true }
            for view in editViews { view.isHidden = false }
            
            NSLayoutConstraint.deactivate(readConstraints)
            NSLayoutConstraint.activate(editConstraints)
        } else {
            for view in editViews { view.isHidden = true }
            for view in readViews { view.isHidden = false }
            
            NSLayoutConstraint.deactivate(editConstraints)
            NSLayoutConstraint.activate(readConstraints)
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func onTap(_ sender: Any) {
        stationSearch.resignFirstResponder()
        aircraftSearch.resignFirstResponder()
        subchapterSearch.resignFirstResponder()
        descriptionText.resignFirstResponder()
    }

}

// MARK: - TableView Delegate / Datasource
extension DetailViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeader.identifier)
        let titleString = section == 0 ? "Details" : "Description"
        header?.textLabel?.text = titleString
        return header
    }
}

// MARK: - Selectors
extension DetailViewController {
    
    @objc func onEditButtonTapped() {
        mode = .edit
        onChangeMode()
    }
    
    @objc func onCancelButtonTapped() {
        if defect == nil {
            navigationController?.popViewController(animated: true)
        } else {
            mode = .read
            onChangeMode()
        }
    }
    
    @objc func onResolveButtonTapped() {
        defect?.resolved = true
        updateDefect()
        configureToolbarItems()
    }
    
    @objc func onArchiveButtonTapped() {
        archiveDefect()
    }
    
    @objc func onSubmitButtonTapped() {
        if defect == nil {
            createDefect()
        } else {
            updateDefect()
        }
    }
    
}

// MARK: Record Modification
extension DetailViewController {
    
    public func getNewDefectFromInput() throws -> Defect {
        guard let sta = stationSearch.text, !sta.isEmpty,
              let ac = aircraftSearch.text, !ac.isEmpty,
              let ata4 = subchapterSearch.text, !ata4.isEmpty,
              let description = descriptionText.text, !description.isEmpty
        else {
            throw ValidationError.missingData
        }
        return Defect(sta, ac, ata4, description)
    }
    
    public func updateDefectFromInput(_ defect: Defect) throws {
        guard let sta = stationSearch.text, !sta.isEmpty,
              let ac = aircraftSearch.text, !ac.isEmpty,
              let ata4 = subchapterSearch.text, !ata4.isEmpty,
              let description = descriptionText.text, !description.isEmpty
        else {
            throw ValidationError.missingData
        }
        defect.sta = sta
        defect.ac = ac
        defect.ata4 = ata4
        defect.description = description
    }
    
    private func createDefect() {
        do {
            defect = try getNewDefectFromInput()
            apiClient.post(defect!)
            repository.addDefectToSections(defect!)
            presentBasicAlert(title: "Defect \(defect!.id) created")
            mode = .read
            onChangeMode()
        } catch {
            presentBasicAlert(title: "Error creating defect")
        }
    }
    
    private func updateDefect() {
        do {
            try updateDefectFromInput(defect!)
            apiClient.put(defect!)
            presentBasicAlert(title: "Defect \(defect!.id) updated")
            mode = .read
            onChangeMode()
        } catch {
            presentBasicAlert(title: "Error updating defect")
        }
    }
    
    private func archiveDefect() {
        apiClient.archive(defect!)
        presentReturningAlert(title: "Defect \(defect!.id) archived")
    }
    
}

// MARK: Toolbar Configuration
extension DetailViewController {
    
    private func getPilotToolbarItems() -> [UIBarButtonItem] {
        if defect!.resolved {
            return getSpacedButtonItems(with: [archiveButton])
        } else {
            return getSpacedButtonItems(with: [resolveButton])
        }
    }
    
    private func getTechnicianToolbarItems() -> [UIBarButtonItem] {
        if mode == .edit {
            return getSpacedButtonItems(with: [cancelButton, submitButton])
        } else {
            return getSpacedButtonItems(with: [editButton])
        }
    }
    
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension DetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar == stationSearch {
            stationDropDown.dataSource = repository.matches(for: .sta, searchText)
            stationDropDown.show()
        }
        
        if searchBar == aircraftSearch {
            aircraftDropDown.dataSource = repository.matches(for: .ac, searchText)
            aircraftDropDown.show()
        }
        
        if searchBar == subchapterSearch {
            subchapterDropDown.dataSource = repository.matches(for: .ata4, searchText)
            subchapterDropDown.show()
        }
    }
}
