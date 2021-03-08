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

class DefectTableViewController: UITableViewController {
    
    let defects = [
        Defect(id: UUID(), description: "defect 1"),
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
    }
    
}
