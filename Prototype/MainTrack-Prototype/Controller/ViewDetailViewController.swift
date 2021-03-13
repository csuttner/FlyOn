//
//  ViewDetailViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class ViewDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var defect: Defect!
    
    let tableView = UITableView()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("   Edit Defect   ", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        return button
    }()
    
    let headers = [
        "Details",
        "Description"
    ]
    
    convenience init(defect: Defect) {
        self.init(nibName: nil, bundle: nil)
        self.defect = defect
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Defect \(defect.id)"
        view.backgroundColor = .systemGray6
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(ViewDetailCell.self, forCellReuseIdentifier: "ViewDetail")
        tableView.register(ViewDescriptionCell.self, forCellReuseIdentifier: "ViewDescription")
        
        view.addSubview(editButton)
        editButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            centerX: view.centerXAnchor,
            paddingBottom: .padding
        )
        
        view.addSubview(tableView)
        tableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: editButton.topAnchor,
            right: view.rightAnchor,
            paddingBottom: .padding
        )
        
        editButton.addTarget(self, action: #selector(onEditDefectTapped), for: .touchUpInside)
    }
    
    @objc func onEditDefectTapped() {
        navigationController?.pushViewController(EditDetailViewController(defect: defect), animated: true)
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ViewDetail") as! ViewDetailCell
            cell.defect = defect
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ViewDescription") as! ViewDescriptionCell
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = defect.description
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionHeaderView(title: headers[section])
    }
    
}
