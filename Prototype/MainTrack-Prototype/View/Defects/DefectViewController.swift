//
//  DefectViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class DefectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onNewDefectTapped(_ sender: Any) {
        navigationController?.pushViewController(EditDetailViewController(), animated: true)
    }
    var db = DefectDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Defects"
        view.backgroundColor = .systemGray6
        tableView.register(DefectCell.self, forCellReuseIdentifier: "ID")
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return db.sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionHeaderView(title: db.sections[section].title)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let label = UILabel()
        label.text = "lol"
        return label.intrinsicContentSize.height + .halfPadding * 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.sections[section].defects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID") as! DefectCell
        cell.defect = db.sections[indexPath.section].defects[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defect = db.sections[indexPath.section].defects[indexPath.row]
        navigationController!.pushViewController(ViewDetailViewController(defect: defect), animated: true)
    }
    
}
