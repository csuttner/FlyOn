//
//  EnterDefectDetailsViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 6/7/21.
//

import UIKit

class EnterDefectDetailsViewController: UIViewController {
    @IBOutlet weak var stationSearchbar: UISearchBar!
    @IBOutlet weak var ataCodeSearchbar: UISearchBar!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var viewModel: EnterDefectDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.prompt = viewModel.aircraftString
    }
}
