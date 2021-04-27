//
//  DetailViewModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 4/23/21.
//

import UIKit
import Combine

class DetailViewModel {
    private var defect: Defect?
    
    var defectExists: Bool {
        return defect != nil
    }
    
    var defectIsResolved: Bool {
        if let defect = defect {
            return defect.isResolved
        }
        
        return false
    }

    let title = CurrentValueSubject<String?, Never>(nil)
    let dateString = CurrentValueSubject<String?, Never>(nil)
    let station = CurrentValueSubject<String?, Never>(nil)
    let aircraft = CurrentValueSubject<String?, Never>(nil)
    let subchapter = CurrentValueSubject<String?, Never>(nil)
    let defectDescription = CurrentValueSubject<String?, Never>(nil)
    let statusContainerColor = CurrentValueSubject<UIColor?, Never>(nil)
    let statusImage = CurrentValueSubject<UIImage?, Never>(nil)
    let statusTintColor = CurrentValueSubject<UIColor?, Never>(nil)
    let status = CurrentValueSubject<String?, Never>(nil)
    
    let resolved = PassthroughSubject<Bool, Never>()
    
    var subscribers = Set<AnyCancellable>()
    
    let apiClient = ApiClient.shared
    let repository = Repository.shared
    
    init(defect: Defect? = nil) {
        self.defect = defect
        configureForDefect()
        configureForStatus()
        setupSubscribers()
    }
    
    func setupSubscribers() {
        resolved.sink { [weak self] resolved in
            self?.defect?.isResolved = resolved
            self?.configureForStatus()
        }.store(in: &subscribers)
    }
    
    func configureForDefect() {
        if let defect = defect {
            title.value = "Defect \(defect.id)"
            dateString.value = defect.defectDate
            station.value = defect.sta
            aircraft.value = defect.ac
            subchapter.value = defect.ata4
            defectDescription.value = defect.defectDescription
        } else {
            title.value = "New Defect"
            dateString.value = Date().getString()
        }
    }
    
    func configureForStatus() {
        if let defect = defect {
            if defect.isResolved {
                statusContainerColor.value = UIColor.white.withGreenHue(saturation: 0.1)
                statusImage.value = UIImage(systemName: "checkmark.circle")!
                statusTintColor.value = UIColor.systemGray.withGreenHue(saturation: 1)
                status.value = "Closed"
            } else {
                statusContainerColor.value = UIColor.white.withRedHue(saturation: 0.1)
                statusImage.value = UIImage(systemName: "xmark.circle")!
                statusTintColor.value = UIColor.systemGray3.withRedHue(saturation: 1)
                status.value = "Open"
            }
        } else {
            statusContainerColor.value = .systemGray6
            statusImage.value = UIImage(systemName: "ellipsis.circle")!
            statusTintColor.value = UIColor.systemGray
            status.value = "Unopened"
        }
    }
    
    func validateInput() throws {
        guard let station = station.value, !station.isEmpty,
              let aircraft = aircraft.value, !aircraft.isEmpty,
              let subchapter = subchapter.value, !subchapter.isEmpty,
              let description = defectDescription.value, !description.isEmpty
        else {
            throw ValidationError.missingData
        }
    }
    
    func getNewDefectFromInput() throws -> Defect {
        try validateInput()
        return Defect(
            station.value!,
            aircraft.value!,
            subchapter.value!,
            defectDescription.value!
        )
    }
    
    func updateDefectFromInput() throws {
        try validateInput()
        defect?.sta = station.value!
        defect?.ac = aircraft.value!
        defect?.ata4 = subchapter.value!
        defect?.defectDescription = defectDescription.value!
    }
    
    func createDefect() throws {
        defect = try getNewDefectFromInput()
        apiClient.post(defect!)
        repository.addDefectToSections(defect!)
        configureForDefect()
        configureForStatus()
    }
    
    func updateDefect() throws {
        try updateDefectFromInput()
        apiClient.put(defect!)
    }
    
    func archiveDefect() {
        if let defect = defect {
            apiClient.archive(defect)
        }
    }
    
    func matches(for attribute: Repository.DefectAttribute, _ searchText: String) -> [String] {
        let strings = repository.stringRepresentations(for: attribute)
        return strings.compactMap {
            $0.lowercased().contains(searchText.lowercased()) ? $0 : nil
        }
    }
}
