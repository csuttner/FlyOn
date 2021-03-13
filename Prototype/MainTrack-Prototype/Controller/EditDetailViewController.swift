//
//  EditDetailViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

protocol UpdatableTableDelegate {
    func updateTable()
}

class EditDetailViewController: UITableViewController, UpdatableTableDelegate {
    
    var defect: Defect?
    
    var detailMode: DetailMode! {
        didSet {
            updateToolBarItems()
            updateTitle()
        }
    }
    
    lazy var submitButton = ActionButton(title: "Submit", color: .systemGreen, target: self, action: #selector(onSubmitButtonTapped))
    lazy var editButton = ActionButton(title: "Edit", color: .systemBlue, target: self, action: #selector(onEditButtonTapped))
    
    let headers = [
        "Details",
        "Description"
    ]
    
    let detailFields = [
        "Station",
        "Aircraft",
        "Ata Chapter",
        "Ata Subchapter"
    ]
    
    convenience init(defect: Defect?, mode: DetailMode) {
        self.init(nibName: nil, bundle: nil)
        self.defect = defect
        self.detailMode = mode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        addGestureRecognizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateToolBarItems()
    }
    
    func updateToolBarItems() {
        let button = detailMode == .edit ? submitButton : editButton
        setToolbarItems([
            UIBarButtonItem(systemItem: .flexibleSpace),
            UIBarButtonItem(customView: button),
            UIBarButtonItem(systemItem: .flexibleSpace)
        ], animated: true)
    }
    
    func configureView() {
        updateTitle()
        view.backgroundColor = .systemGray6
    }
    
    func updateTitle() {
        if let defect = defect {
            title = detailMode == .edit ? "Edit \(defect.id)" : "Defect \(defect.id)"
        } else {
            title = "New Defect"
        }
    }
    
    func configureTableView() {
        tableView.backgroundColor = .systemGray6
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func addGestureRecognizers() {
        let tappedNavbar = UITapGestureRecognizer()
        let tappedView = UITapGestureRecognizer()
        tappedNavbar.addTarget(self, action: #selector(onTap))
        tappedView.addTarget(self, action: #selector(onTap))
        navigationController?.navigationBar.addGestureRecognizer(tappedNavbar)
        view.addGestureRecognizer(tappedView)
    }
    
    @objc func onTap() {
        NotificationCenter.default.post(name: .keyboardNeedsDismissing, object: nil)
    }
    
    @objc func onSubmitButtonTapped() {
        var title: String?
        var message: String?
        
        if let defect = defect {
            title = "Defect \(defect.id) Updated"
        } else {
            title = "Defect Created"
            message = "id: \(UUID.shortString())"
        }
        
        let submitAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (nil) in
            self.detailMode = .view
            self.tableView.reloadData()
        }
        
        submitAlert.addAction(okAction)
        present(submitAlert, animated: true)
    }
    
    @objc func onEditButtonTapped() {
        detailMode = .edit
        tableView.reloadData()
    }
    
    func updateTable() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }

}

// UITableViewDataSource
extension EditDetailViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

// UITableViewDelegate
extension EditDetailViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionHeaderView(title: headers[section])
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let label = UILabel()
        label.text = "lol"
        return label.intrinsicContentSize.height + .halfPadding * 2
    }
    
}
