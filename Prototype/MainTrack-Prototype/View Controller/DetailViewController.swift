//
//  NewDetailViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit
import DropDown
import Combine

class DetailViewController: UITableViewController {
    private let repository = Repository.shared

    var viewModel: DetailViewModel!
    var mode: Mode!
    
    public enum Mode {
        case edit
        case read
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusContainer: RoundedView!
    @IBOutlet weak var statusIndicator: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
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
    
    var bindings = [AnyCancellable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
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
        configureToolbarItems()
        configureModeViews()
    }
    
    private func setupBinding() {
        bindings = [
            viewModel.title.assign(to: \.text, on: titleLabel),
            viewModel.statusContainerColor.assign(to: \.backgroundColor, on: statusContainer),
            viewModel.statusImage.assign(to: \.image, on: statusIndicator),
            viewModel.statusTintColor.assign(to: \.tintColor, on: statusIndicator),
            viewModel.status.assign(to: \.text, on: statusLabel),
            viewModel.statusTintColor.assign(to: \.textColor, on: statusLabel),
            viewModel.dateString.assign(to: \.text, on: dateLabel),
            viewModel.station.assign(to: \.text, on: stationLabel),
            viewModel.station.assign(to: \.text, on: stationSearch),
            viewModel.aircraft.assign(to: \.text, on: aircraftLabel),
            viewModel.aircraft.assign(to: \.text, on: aircraftSearch),
            viewModel.subchapter.assign(to: \.text, on: subchapterLabel),
            viewModel.subchapter.assign(to: \.text, on: subchapterSearch),
            viewModel.description.assign(to: \.text, on: descriptionLabel),
            viewModel.description.assign(to: \.text, on: descriptionText),
        ]
    }
    
    private func configureToolbarItems() {
        navigationController?.isToolbarHidden = false
        
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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeader.identifier) as! SectionHeader
        header.textLabel?.text = section == 0 ? "" : "Defect Description"
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}

// MARK: - Selectors
extension DetailViewController {
    
    @objc func onEditButtonTapped() {
        mode = .edit
        onChangeMode()
    }
    
    @objc func onCancelButtonTapped() {
        if viewModel.defectExists {
            navigationController?.popViewController(animated: true)
        } else {
            mode = .read
            onChangeMode()
        }
    }
    
    @objc func onResolveButtonTapped() {
        viewModel.resolved.send(true)
        updateDefect()
        configureToolbarItems()
    }
    
    @objc func onArchiveButtonTapped() {
        viewModel.archiveDefect()
        presentReturningAlert(title: "Defect archived")
    }
    
    @objc func onSubmitButtonTapped() {
        if viewModel.defectExists {
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
            try viewModel.createDefect()
            presentBasicAlert(title: "Defect created")
            mode = .read
            onChangeMode()
        } catch {
            presentBasicAlert(title: "Error creating defect")
        }
    }
    
    private func updateDefect() {
        do {
            try viewModel.updateDefect()
            presentBasicAlert(title: "Defect updated")
            mode = .read
            onChangeMode()
        } catch {
            presentBasicAlert(title: "Error updating defect")
        }
    }
}

// MARK: Toolbar Configuration
extension DetailViewController {
    
    private func getPilotToolbarItems() -> [UIBarButtonItem] {
        if viewModel.defectResolved {
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
        
        viewModel.description.send(textView.text)
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
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar == stationSearch {
            viewModel.station.send(searchBar.text)
        }
        
        if searchBar == aircraftSearch {
            viewModel.aircraft.send(searchBar.text)
        }
        
        if searchBar == subchapterSearch {
            viewModel.subchapter.send(searchBar.text)
        }
    }
}
