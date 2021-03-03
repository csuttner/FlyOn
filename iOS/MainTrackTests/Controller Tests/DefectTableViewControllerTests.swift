//
//  DefectTableViewControllerTests.swift
//  MainTrackTests
//
//  Created by Clay Suttner on 3/2/21.
//

import Foundation
import XCTest
@testable import MainTrack

class DefectTableViewControllerTests: XCTestCase {
    
    func test_initializes_withTitleEqualToDefects() {
        XCTAssertEqual(makeSut().title!, "Defects")
    }
    
    func test_viewWillAppear_hidesBackButton() {
        let sutInNavController = makeSutInNavController()
        let defectTable = sutInNavController.topViewController
        
        defectTable!.viewWillAppear(false)
        
        XCTAssertTrue(defectTable!.navigationItem.hidesBackButton)
    }
    
    func test_viewWillAppear_setsPreffersLargeTitlesTrue() {
        let sutInNavController = makeSutInNavController()
        let defectTable = sutInNavController.topViewController
        
        defectTable!.viewWillAppear(false)
        
        XCTAssertEqual(defectTable!.navigationController?.navigationBar.prefersLargeTitles, true)
    }
    
    func test_viewWillAppear_addsUserMenuButton() {
        let sutInNavController = makeSutInNavController()
        let defectTable = sutInNavController.topViewController
        
        defectTable!.viewWillAppear(false)
        
        XCTAssertTrue(defectTable?.navigationItem.rightBarButtonItem?.customView is UIButton)
    }
    
    func test_viewWillAppear_unHidesNavBar() {
        let sutInNavController = makeSutInNavController()
        sutInNavController.navigationBar.isHidden = true
        
        sutInNavController.topViewController?.viewWillAppear(false)
        
        XCTAssertFalse(sutInNavController.navigationBar.isHidden)
    }
    
    func makeSut() -> DefectTableViewController {
        let sut = DefectTableViewController()
        _ = sut.view
        
        return sut
    }
    
    func makeSutInNavController() -> NonAnimatedNavigationController {
        let sutInNavController =  NonAnimatedNavigationController(rootViewController: LoginViewController())
        
        sutInNavController.pushViewController(DefectTableViewController(), animated: false)

        return sutInNavController
    }
    
    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
}
