//
//  NewRegistrationTests.swift
//  LocadoraOleTrainingTests
//
//  Created by Lorena Rodrigues on 17/12/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import XCTest
import InstantMock

@testable import LocadoraOleTraining

class NewRegistrationTests: XCTestCase {
    
    var newRegistrationVC: NewRegistrationViewController!
    var newRegistrationVM = NewRegistrationViewModel()
    
    
    class MockAPIManager: APIManager, MockDelegate {
        var getMockServiceCalled = false
        let completeName = "Novo usuario"
        let username = "novousuario"
        let password = "123abc"
        private let mock = Mock()
        
        var it: Mock {
            return mock
        }
        
        override func createNewUser(email: String, password: String, completeName: String, username: String, completion: @escaping (Bool?) -> Void) {
            getMockServiceCalled = true
            if password == self.password && completeName == self.completeName && username == self.username {
                completion(true)
            }
            
        }
    }
    
    func testRegistrateValidUser() {
        let mock = MockAPIManager()
        newRegistrationVC.textFieldFullName.text = "Novo usuario"
        newRegistrationVC.textFieldUsername.text = "novousuario"
        newRegistrationVC.textFieldPassword.text = "123abc"
        
        mock.it.expect().call(
            mock.it.stub().call(
                mock.createNewUser(email: "usuario@inexistent.com", password: newRegistrationVC.textFieldPassword.text!, completeName: newRegistrationVC.textFieldFullName.text!, username: newRegistrationVC.textFieldUsername.text!, completion: { (result) in
                    
                })
            )
        )
        newRegistrationVC.textFieldDidEndEditing(newRegistrationVC.textFieldPassword)
        newRegistrationVC.textFieldDidEndEditing(newRegistrationVC.textFieldUsername)
        newRegistrationVC.textFieldDidEndEditing(newRegistrationVC.textFieldFullName)
        XCTAssertTrue(mock.getMockServiceCalled)
        XCTAssertEqual(newRegistrationVC.emailUser, "usuario@inexistent.com")
        
        newRegistrationVC.buttonGo.sendActions(for: .touchUpInside)
        
    }
    
    func testWrongName() {
        newRegistrationVC.textFieldFullName.text = "usuario1"
        newRegistrationVC.textFieldDidEndEditing(newRegistrationVC.textFieldFullName)
    }
    
    func testWrongUsername() {
        newRegistrationVC.textFieldUsername.text = "usuario&"
        newRegistrationVC.textFieldDidEndEditing(newRegistrationVC.textFieldUsername)
    }
    
    func testWrongPassword() {
        newRegistrationVC.textFieldFullName.text = "123456"
        newRegistrationVC.textFieldDidEndEditing(newRegistrationVC.textFieldPassword)
    }
    

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "cadastro")
        newRegistrationVC = (navigationController as! NewRegistrationViewController)
        newRegistrationVC.emailUser = "usuario@inexistent.com"
        
        UIApplication.shared.keyWindow!.rootViewController = newRegistrationVC
        let _ = newRegistrationVC.view
        
    }

    override func tearDown() {
        newRegistrationVC = nil
    }

    

}
