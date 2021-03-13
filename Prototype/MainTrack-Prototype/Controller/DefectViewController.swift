//
//  DefectViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class DefectViewController: UIViewController {
    
    let db = DefectDatabase()
    let tableView = UITableView()
    let newDefectButton = ActionButton(title: "   New Defect   ", color: .systemGreen)

    override func viewDidLoad() {
        super.viewDidLoad()
        formatView()
        setupSubviews()
        configureTableView()
        configureNavigationController()
        addNewDefectButtonAction()
    }
    
    private func formatView() {
        title = "Defects"
        view.backgroundColor = .systemGray6
    }
    
    private func setupSubviews() {
        view.addSubview(newDefectButton)
        newDefectButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            centerX: view.centerXAnchor,
            paddingBottom: .padding
        )
        
        view.addSubview(tableView)
        tableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: newDefectButton.topAnchor,
            right: view.rightAnchor,
            paddingBottom: .padding
        )
    }
    
    private func configureTableView() {
        tableView.register(DefectCell.self, forCellReuseIdentifier: "ID")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
    }
    
    private func addNewDefectButtonAction() {
        newDefectButton.addTarget(self, action: #selector(onNewDefectButtonTapped), for: .touchUpInside)
    }
    
    @objc func onNewDefectButtonTapped() {
        navigationController?.pushViewController(ViewDetailViewController(), animated: true)
    }

}

extension DefectViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return db.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.sections[section].defects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID") as! DefectCell
        cell.defect = db.sections[indexPath.section].defects[indexPath.row]
        return cell
    }
    
}

extension DefectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionHeaderView(title: db.sections[section].title)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let label = UILabel()
        label.text = "lol"
        return label.intrinsicContentSize.height + .halfPadding * 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defect = db.sections[indexPath.section].defects[indexPath.row]
        navigationController!.pushViewController(ViewDetailViewController(defect: defect), animated: true)
    }
    
}
