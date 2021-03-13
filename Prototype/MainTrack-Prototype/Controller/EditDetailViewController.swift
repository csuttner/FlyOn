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

class EditDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdatableTableDelegate {
    
    var defect: Defect?
    
    let tableView = UITableView()
    
    let submitButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("   Submit   ", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        return button
    }()
    
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
    
    convenience init(defect: Defect) {
        self.init(nibName: nil, bundle: nil)
        self.defect = defect
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = defect == nil ? "New Defect" : "Edit \(defect!.id)"
        view.backgroundColor = .systemGray6
        tableView.backgroundColor = .systemGray6
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.register(EditDetailCell.self, forCellReuseIdentifier: "EditDetail")
        tableView.register(EditDescriptionCell.self, forCellReuseIdentifier: "EditDescription")
        tableView.tableFooterView = UIView(frame: .zero)
        
        let tappedNavbar = UITapGestureRecognizer()
        let tappedTable = UITapGestureRecognizer()
        tappedNavbar.addTarget(self, action: #selector(onTap))
        tappedTable.addTarget(self, action: #selector(onTap))
        navigationController?.navigationBar.addGestureRecognizer(tappedNavbar)
        view.addGestureRecognizer(tappedTable)
        
        submitButton.addTarget(self, action: #selector(onSubmitButtonTapped), for: .touchUpInside)
        
        view.addSubview(submitButton)
        submitButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            centerX: view.centerXAnchor,
            paddingBottom: .padding
        )
        
        view.addSubview(tableView)
        tableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: submitButton.topAnchor,
            right: view.rightAnchor,
            paddingBottom: .padding
        )
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
            self.navigationController?.popViewController(animated: true)
        }
        
        submitAlert.addAction(okAction)
        present(submitAlert, animated: true)
    }
    
    
    func updateTable() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditDetail") as! EditDetailCell
            cell.defect = defect
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditDescription") as! EditDescriptionCell
            cell.defect = defect
            cell.tableDelegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let label = UILabel()
        label.text = "lol"
        return label.intrinsicContentSize.height + .halfPadding * 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionHeaderView(title: headers[section])
    }
}
