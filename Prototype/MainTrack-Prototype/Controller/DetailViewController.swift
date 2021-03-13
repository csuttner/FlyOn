//
//  DetailViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

enum DetailMode {
    case view
    case edit
}

class DetailViewController: UIViewController {
    
    private var defect: Defect?
    private var readView: ReadDefectView!
    private var editView: EditDefectView!
    private var mode: DetailMode!
    
    convenience init(defect: Defect?, mode: DetailMode) {
        self.init(nibName: nil, bundle: nil)
        self.mode = mode
        self.readView = ReadDefectView(defect)
        self.editView = EditDefectView(defect)
        setView(for: mode)
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .systemGray6
        if let defect = defect {
            title = mode == .edit ? "Edit \(defect.id)" : "Defect \(defect.id)"
        } else {
            title = "New Defect"
        }
    }
    
    private func setView(for mode: DetailMode) {
        mode == .edit ? setEditView() : setReadView()
    }
    
    private func setEditView() {
        readView.removeFromSuperview()
        view.addSubview(editView)
        editView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor
        )
    }
    
    private func setReadView() {
        editView.removeFromSuperview()
        view.addSubview(readView)
        readView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor
        )
    }
}
