//
//  DefectTableViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/8/21.
//

import UIKit

struct Defect {
    let id: UUID
    let defectDate: Date? = nil
    let resolvedDate: Date? = nil
    let resolved: Bool? = nil
    let description: String
    let ac: String? = nil
    let sta: String? = nil
    let ata4: String? = nil
}

class TableViewCell: UITableViewCell {
    var defect: Defect! {
        didSet{
            textLabel!.text = defect.description
        }
    }
}

class DefectTableViewController: UITableViewController {
    
    let defects = [
        Defect(id: UUID(), description: "The soap dispenser in lavitory 4 is completely broken and needs replacing"),
        Defect(id: UUID(), description: "defect 2"),
        Defect(id: UUID(), description: "defect 3"),
        Defect(id: UUID(), description: "defect 4"),
        Defect(id: UUID(), description: "defect 5"),
        Defect(id: UUID(), description: "defect 6"),
        Defect(id: UUID(), description: "defect 7"),
        Defect(id: UUID(), description: "defect 8"),
        Defect(id: UUID(), description: "defect 9"),
        Defect(id: UUID(), description: "defect 10"),
        Defect(id: UUID(), description: "defect 11"),
        Defect(id: UUID(), description: "defect 12"),
        Defect(id: UUID(), description: "defect 13")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "ID")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID") as! TableViewCell
        cell.defect = defects[indexPath.row]
        return cell
    }
}
