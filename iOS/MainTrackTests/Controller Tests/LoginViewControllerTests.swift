//
//  LoginViewControllerTests.swift
//  MainTrackTests
//
//  Created by Clay Suttner on 2/21/21.
//

import Foundation
import XCTest
@testable import MainTrack

class LoginViewControllerTests: XCTestCase {
    
    func test_viewDidLoad_addsLoginViewToView() {
        let sut = makeSut()
        let loginView = sut.loginView
        
        XCTAssertTrue(sut.view.subviews.contains(loginView))
    }
    
    func test_viewDidLoad_centersLoginViewInView() {
        let sut = makeSut()
        let loginView = sut.loginView
        
        XCTAssertEqual(sut.view.frame.midX, loginView.frame.midX)
        XCTAssertEqual(sut.view.frame.midY, loginView.frame.midY)
    }
    
    func test_viewDidLoad_setsBackgroundColorToSystemBackground() {
        XCTAssertEqual(makeSut().view.backgroundColor, .systemBackground)
    }
    
    func test_viewWillAppear_hidesNavigationBar() {
        let sutInNavController = makeSutInNavController()
        let sut = sutInNavController.viewControllers[0]
        
        sut.viewWillAppear(false)
        
        XCTAssertTrue(sutInNavController.navigationBar.isHidden)
    }
    
    func test_onLoginButtonTapped_pushesDefectTable() {
        let sutInNavController = makeSutInNavController()
        let sut = sutInNavController.viewControllers[0] as! LoginViewController
        
        sut.onLoginButtonTapped()
        
        XCTAssertTrue(sutInNavController.topViewController is DefectTableViewController)
    }
    
    func makeSut() -> LoginViewController {
        let sut = LoginViewController()
        _ = sut.view
        return sut
    }
    
    func makeSutInNavController() -> NonAnimatedNavigationController {
        let sutInNavController =  NonAnimatedNavigationController(rootViewController: LoginViewController())
        
        return sutInNavController
    }
    
    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
}
