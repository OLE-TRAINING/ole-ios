//
//  LoginTests.swift
//  LocadoraOleTrainingTests
//
//  Created by Lorena Rodrigues on 17/12/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import XCTest
import InstantMock

@testable import LocadoraOleTraining

class LoginTests: XCTestCase {

    var loginVC: LoginViewController!
    var loginVM = LoginViewModel()
    
    class MockAPIManager: APIManager, MockDelegate {
        private let mock = Mock()
        var getMockLoginServiceCalled = false
        
        var it: Mock {
            return mock
        }
        
        override func authenticateUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
            getMockLoginServiceCalled = true
            completion(true)
        }
    }
    
    func testLogin() {
        let mock = MockAPIManager()
        XCTAssertEqual(loginVC.emailUser, "usuario@registered.com")
        loginVC.textFieldPassword.text = "123aaa"
        loginVC.textFieldDidEndEditing(loginVC.textFieldPassword)
        mock.it.expect().call(
            mock.it.stub().call(
                mock.authenticateUser(email: loginVC.emailUser!, password: loginVC.textFieldPassword.text!, completion: { (result) in
                    
                })
            )
        )
        
        loginVC.buttonLogIn.sendActions(for: .touchUpInside)
        XCTAssertTrue(mock.getMockLoginServiceCalled)
    }
    
    func testInvalidPassword() {
        loginVC.textFieldPassword.text = "123456"
        loginVC.textFieldDidEndEditing(loginVC.textFieldPassword)
    }
    
    func testForgotPassword() {
        loginVC.buttonForgotPassword.sendActions(for: .touchUpInside)
    }
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "login")
        loginVC = (navigationController as! LoginViewController)
        loginVC.emailUser = "usuario@registered.com"
        
        UIApplication.shared.keyWindow!.rootViewController = loginVC
        let _ = loginVC.view
    }

    override func tearDown() {
        loginVC = nil
    }


}
