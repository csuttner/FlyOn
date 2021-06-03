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
    var viewModel: DetailViewModel!
    var readOnly: Bool!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusContainer: RoundedView!
    @IBOutlet weak var statusIndicator: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var aircraftLabel: UILabel!
    @IBOutlet weak var subchapterLabel: UILabel!
    @IBOutlet weak var defectDescriptionLabel: UILabel!
    @IBOutlet weak var resolutionDescriptionLabel: UILabel!
    
    @IBOutlet var readViews: [UIView]!
    @IBOutlet var readConstraints: [NSLayoutConstraint]!
    
    @IBOutlet weak var stationSearch: UISearchBar!
    @IBOutlet weak var aircraftSearch: UISearchBar!
    @IBOutlet weak var subchapterSearch: UISearchBar!
    @IBOutlet weak var defectDescriptionText: DescriptionTextView!
    @IBOutlet weak var resolutionDescriptionText: DescriptionTextView!
    
    @IBOutlet var editViews: [UIView]!
    @IBOutlet var editConstraints: [NSLayoutConstraint]!
    
    @IBOutlet weak var stationAnchor: UIView!
    @IBOutlet weak var aircraftAnchor: UIView!
    @IBOutlet weak var subchapterAnchor: UIView!
    
    private lazy var stationDropDown = DropDown(anchorView: stationAnchor)
    private lazy var aircraftDropDown = DropDown(anchorView: aircraftAnchor)
    private lazy var subchapterDropDown = DropDown(anchorView: subchapterAnchor)
    
    let headerTitles = ["", "Defect Description", "Resolution Description"]
    
    lazy var editButton = ActionButton(title: "Edit", color: .systemBlue, target: self, action: #selector(onEditButtonTapped))
    lazy var cancelButton = ActionButton(title: "Cancel", color: .systemGray, target: self, action: #selector(onCancelButtonTapped))
    lazy var submitButton = ActionButton(title: "Submit", color: .systemGreen, target: self, action: #selector(onSubmitButtonTapped))
    lazy var resolveButton = ActionButton(title: "Close", color: .systemGreen, target: self, action: #selector(onCloseButtonTapped))
    lazy var archiveButton = ActionButton(title: "Archive", color: .systemGray, target: self, action: #selector(onArchiveButtonTapped))
    
    var bindings = [AnyCancellable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SectionHeader.nib, forHeaderFooterViewReuseIdentifier: SectionHeader.identifier)
        
        setupBinding()
        setupDropDowns()
        setupFor(readOnly: readOnly)
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
            viewModel.defectDescription.assign(to: \.text, on: defectDescriptionLabel),
            viewModel.defectDescription.assign(to: \.text, on: defectDescriptionText),
            viewModel.resolutionDescription.assign(to: \.text, on: resolutionDescriptionLabel),
            viewModel.resolutionDescription.assign(to: \.text, on: resolutionDescriptionText)
        ]
    }
    
    private func setupDropDowns() {
        stationDropDown.selectionAction = { [weak self] in self?.viewModel.station.send($1) }
        aircraftDropDown.selectionAction = { [weak self] in self?.viewModel.aircraft.send($1) }
        subchapterDropDown.selectionAction = { [weak self] in self?.viewModel.subchapter.send($1) }
    }
    
    private func setupFor(readOnly: Bool) {
        self.readOnly = readOnly
        configureModeViews()
    }
    
    private func configureModeViews() {
        if readOnly {
            for view in editViews { view.isHidden = true }
            for view in readViews { view.isHidden = false }
            
            NSLayoutConstraint.deactivate(editConstraints)
            NSLayoutConstraint.activate(readConstraints)
        } else {
            for view in readViews { view.isHidden = true }
            for view in editViews { view.isHidden = false }
            
            NSLayoutConstraint.deactivate(readConstraints)
            NSLayoutConstraint.activate(editConstraints)
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func onTapGesture(_ sender: Any) {
        stationSearch.resignFirstResponder()
        aircraftSearch.resignFirstResponder()
        subchapterSearch.resignFirstResponder()
        defectDescriptionText.resignFirstResponder()
        resolutionDescriptionText.resignFirstResponder()
    }

}

// MARK: - TableView Delegate / Datasource
extension DetailViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeader.identifier) as! SectionHeader
        header.textLabel?.text = headerTitles[section]
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}

// MARK: - Selectors
extension DetailViewController {
    
    @objc func onEditButtonTapped() {
        setupFor(readOnly: false)
    }
    
    @objc func onCancelButtonTapped() {
        if viewModel.defectExists {
            setupFor(readOnly: true)
            viewModel.configureForDefect()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func onCloseButtonTapped() {
        do {
            try viewModel.resolveDefect()
            updateDefect()
        } catch {
            presentBasicAlert(title: "A resolution description is required to close")
        }
    }
    
    @objc func onArchiveButtonTapped() {
        viewModel.archiveDefect()
        presentReturningAlert(title: "Defect archived")
    }
    
    @objc func onSubmitButtonTapped() {
        if viewModel.defectExists {
            updateDefect()
        } else {
            createDefect()
        }
    }
    
}

// MARK: Record Modification
extension DetailViewController {
    
    private func createDefect() {
        do {
            try viewModel.createDefect()
            presentBasicAlert(title: "Defect created")
            setupFor(readOnly: true)
        } catch {
            presentBasicAlert(title: "Error creating defect")
        }
    }
    
    private func updateDefect() {
        do {
            try viewModel.updateDefect()
            presentBasicAlert(title: "Defect updated")
            setupFor(readOnly: true)
        } catch {
            presentBasicAlert(title: "Error updating defect")
        }
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if textView == defectDescriptionText {
            viewModel.defectDescription.send(textView.text)
        }
        
        if textView == resolutionDescriptionText {
            viewModel.resolutionDescription.send(textView.text)
        }
    }
}

extension DetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar == stationSearch {
            stationDropDown.dataSource = viewModel.matches(for: .sta, searchText)
            stationDropDown.show()
            
            viewModel.station.send(searchBar.text)
        }
        
        if searchBar == aircraftSearch {
            aircraftDropDown.dataSource = viewModel.matches(for: .ac, searchText)
            aircraftDropDown.show()
            
            viewModel.aircraft.send(searchBar.text)
        }
        
        if searchBar == subchapterSearch {
            subchapterDropDown.dataSource = viewModel.matches(for: .ata4, searchText)
            subchapterDropDown.show()
            
            viewModel.subchapter.send(searchBar.text)
        }
    }
}
