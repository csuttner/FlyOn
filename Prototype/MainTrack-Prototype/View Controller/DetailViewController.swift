//
//  NewDetailViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var openCloseLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!

    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var aircraftLabel: UILabel!
    @IBOutlet weak var subchapterLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var stationSearch: UISearchBar!
    @IBOutlet weak var aircraftSearch: UISearchBar!
    @IBOutlet weak var subchapterSearch: UISearchBar!
    @IBOutlet weak var descriptionText: DescriptionTextView!
    
    @IBOutlet weak var stationAnchor: UIView!
    @IBOutlet weak var aircraftAnchor: UIView!
    @IBOutlet weak var subchapterAnchor: UIView!
    
    @IBOutlet weak var readView: UIView!
    @IBOutlet weak var editView: UIView!
    
    private let repository = Repository.shared
    private let apiClient = ApiClient.shared
    
    var defect: Defect?
    var mode: Mode!
    
    lazy var editButton = ActionButton(title: "Edit", color: .systemBlue, target: self, action: #selector(onEditButtonTapped))
    lazy var cancelButton = ActionButton(title: "Cancel", color: .systemGray, target: self, action: #selector(onCancelButtonTapped))
    lazy var submitButton = ActionButton(title: "Submit", color: .systemGreen, target: self, action: #selector(onSubmitButtonTapped))
    lazy var resolveButton = ActionButton(title: "Close", color: .systemGreen, target: self, action: #selector(onResolveButtonTapped))
    lazy var archiveButton = ActionButton(title: "Archive", color: .systemGray, target: self, action: #selector(onArchiveButtonTapped))
    
    public enum Mode {
        case edit
        case read
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onChangeMode()
    }
    
    private func configureForDefect() {
        if let defect = defect {
            openCloseLabel.text = defect.resolved ? "Closed" : "Open"
            stationLabel.text = defect.sta
            aircraftLabel.text = defect.ac
            subchapterLabel.text = defect.ata4
            descriptionLabel.text = defect.description
            
            stationSearch.text = defect.sta
            aircraftSearch.text = defect.ac
            subchapterSearch.text = defect.ata4
            descriptionText.text = defect.description
        } else {
            openCloseLabel.text = "Unopened"
            stationLabel.text = ""
            aircraftLabel.text = ""
            subchapterLabel.text = ""
            descriptionLabel.text = ""
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        stationSearch.resignFirstResponder()
        aircraftSearch.resignFirstResponder()
        subchapterSearch.resignFirstResponder()
        descriptionText.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    private func configureTitle() {
        if let defect = defect {
            title = mode == .edit ? "Edit \(defect.id)" : "Defect \(defect.id)"
        } else {
            title = "New Defect"
        }
    }
    
    private func configureModeViews() {
        if mode == .edit {
            readView.isHidden = true
            editView.isHidden = false
        } else {
            readView.isHidden = false
            editView.isHidden = true
        }
    }
}


// MARK: - Selectors
extension DetailViewController {
    
    @objc func onChangeMode() {
        configureForDefect()
        configureTitle()
        configureToolbarItems()
        configureModeViews()
    }
    
    @objc func onEditButtonTapped() {
        mode = .edit
        onChangeMode()
    }
    
    @objc func onCancelButtonTapped() {
        mode = .read
        onChangeMode()
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
    
    private func configureToolbarItems() {
        if userData.role == .pilot {
            setToolbarItems(getPilotToolbarItems(), animated: true)
        } else {
            setToolbarItems(getTechnicianToolbarItems(), animated: true)
        }
    }
    
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
