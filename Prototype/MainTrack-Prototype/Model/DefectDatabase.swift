//
//  DefectDatabase.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/8/21.
//

import Foundation

class DefectDatabase {
    
    var sections = [DefectSection]()
    
    let dateAdding: (Double) -> Date = { days in
        let seconds: TimeInterval = 24 * 60 * 60 * days
        return Date(timeIntervalSinceNow: seconds)
    }
    
    lazy var defects = [
        Defect(description: "The soap dispenser in lavitory 4 is completely broken and needs replacing", date: dateAdding(0), ac: "VA845" , sta: "SFO", ata4: "5011", resolved: false),
        Defect(description: "Part ID 345345343 must be replaced immediately. Please place express order", date: dateAdding(0), ac: "VA445" , sta: "SFO", ata4: "2031", resolved: false),
        Defect(description: "The starboard engine has a small fracture in one of the fan blades FIX ASAP", date: dateAdding(3), ac: "VA747" , sta: "SFO", ata4: "4531", resolved: false),
        Defect(description: "Seats 22A, 45D, and 88C have broken seatbelts. These must be replaced immediately", date: dateAdding(3), ac: "VA612" , sta: "SFO", ata4: "3222", resolved: true),
        Defect(description: "There is a problem with the altimieter on the copilot's side. Tests should be run.", date: dateAdding(4), ac: "VA225" , sta: "SFO", ata4: "5344", resolved: false),
        Defect(description: "There is a spill in the galley that needs to be mopped up ASAP", date: dateAdding(4), ac: "VA990" , sta: "SFO", ata4: "3311", resolved: true),
        Defect(description: "Part ID 342342423 is in need of replacement. Place special order immediately.", date: dateAdding(4), ac: "VA566" , sta: "SFO", ata4: "4151", resolved: true),
        Defect(description: "Part ID 342342423 is in need of replacement. Place special order immediately.", date: dateAdding(4), ac: "VA566" , sta: "SFO", ata4: "4151", resolved: false),
        Defect(description: "Clean engine manifolds per specification X77VYCT within 10 days", date: dateAdding(5), ac: "VA555" , sta: "SFO", ata4: "6011", resolved: true),
        Defect(description: "Perform comprehensive systems check on fly by wire controls", date: dateAdding(5), ac: "VA845" , sta: "SFO", ata4: "9021", resolved: true),
        Defect(description: "Wipe down the inside of the windshield using special-grade windex", date: dateAdding(5), ac: "VA332" , sta: "SFO", ata4: "7820", resolved: true),
    ]
    
    init() {
        for defect in defects {
            if let index = sections.firstIndex(where: { $0.title == defect.defectDate.headerStyle() }) {
                sections[index].defects.append(defect)
            } else {
                sections.append(DefectSection(date: defect.defectDate, defects: [defect]))
            }
        }
    }
}
