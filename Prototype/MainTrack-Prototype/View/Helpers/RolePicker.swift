//
//  RolePicker.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/19/21.
//

import UIKit

class RolePicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var role: Role {
        let row = selectedRow(inComponent: 0)
        return Role.allCases[row]
    }
    
    convenience init() {
        self.init(frame: .zero)
        dataSource = self
        delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Role.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Role.allCases[row].rawValue
    }
    
}
