//
//  PreLoginTests.swift
//  LocadoraOleTrainingTests
//
//  Created by Lorena Rodrigues Bruno on 05/12/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import XCTest
import InstantMock
import Foundation

@testable import LocadoraOleTraining

class PreLoginTests: XCTestCase {
    var preLoginVC: PreLoginViewController!
    var preLoginVM = PreLoginViewModel()
    
    class MockAPIManager: APIManager, MockDelegate {
        var getEmailWasCalled = false
        var resultEmailInexistent = UsersInfo(email: "usuario@inexistent.com", completeName: nil, username: nil, registrationStatus: "INEXISTENT")
        var resultEmailPending = UsersInfo(email: "usuario@pending.com", completeName: "usuario pendente", username: "pendente", registrationStatus: "PENDING")
        var resultEmailRegistered = UsersInfo(email: "usuario@registered.com", completeName: "usuario registrado" , username: "novousuarioRegistrado", registrationStatus: "REGISTERED")
        
        private let mock = Mock()
        
        var it: Mock {
            return mock
        }
        
        
        override func getUserWithEmail(_ email: String, completion: @escaping (UsersInfo?) -> Void) {
            getEmailWasCalled = true
            if email == "usuario@inexistent.com" {
                completion(resultEmailInexistent)
            } else if email == "usuario@pending.com" {
                completion(resultEmailPending)
            } else if email == "usuario@registered.com" {
                completion(resultEmailRegistered)
            }
            
        }
        
        
    }
    
    func testGetEmailInexistent() {
        
        let expectation = XCTestExpectation(description: "Teste de cadastro inexistente")
        let mock = MockAPIManager()
        preLoginVC.textFieldEmail.text = "usuario@inexistent.com"
        let email = preLoginVC.textFieldEmail.text
        
        mock.it.stub().call(
            mock.getUserWithEmail(email!, completion: { (result) in
    
            })
        ).andReturn(true)

        preLoginVM.startAplication(labelEmail: preLoginVC.labelEmail, stackInvalidEmail: preLoginVC.stackInvalidEmail)
        preLoginVC.textFieldDidEndEditing(preLoginVC.textFieldEmail)
//        preLoginVC.checkEmail()
//        preLoginVM.checkEmail(textFieldEmail: preLoginVC.textFieldEmail, buttonGo: preLoginVC.buttonGo)
        preLoginVC.textFieldDidEndEditing(preLoginVC.textFieldEmail)
        preLoginVC.buttonGo.sendActions(for: .touchUpInside)
        preLoginVC.goToRegistrationScreen()
        XCTAssertTrue(mock.getEmailWasCalled)
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetEmailPending() {
        
        let expectation = XCTestExpectation(description: "Teste de cadastro pendente")
        let mock = MockAPIManager()
        preLoginVC.textFieldEmail.text = "usuario@pending.com"
        let email = preLoginVC.textFieldEmail.text
        
        mock.it.stub().call(
            mock.getUserWithEmail(email!, completion: { (result) in
                
            })
            ).andReturn(true)
        
        preLoginVM.startAplication(labelEmail: preLoginVC.labelEmail, stackInvalidEmail: preLoginVC.stackInvalidEmail)
        preLoginVC.textFieldDidEndEditing(preLoginVC.textFieldEmail)
        preLoginVC.textFieldDidEndEditing(preLoginVC.textFieldEmail)
//        preLoginVM.checkEmail(textFieldEmail: preLoginVC.textFieldEmail, buttonGo: preLoginVC.buttonGo)
        preLoginVC.buttonGo.sendActions(for: .touchUpInside)
        preLoginVC.goToRegistrationScreen()
        XCTAssertTrue(mock.getEmailWasCalled)
        expectation.fulfill()
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetEmailRegistered() {
        
        let expectation = XCTestExpectation(description: "Teste de cadastro registrado")
        let mock = MockAPIManager()
        preLoginVC.textFieldEmail.text = "usuario@registered.com"
        let email = preLoginVC.textFieldEmail.text
        
        mock.it.stub().call(
            mock.getUserWithEmail(email!, completion: { (result) in
                
            })
            ).andReturn(true)
        
        preLoginVM.startAplication(labelEmail: preLoginVC.labelEmail, stackInvalidEmail: preLoginVC.stackInvalidEmail)
        preLoginVC.textFieldDidEndEditing(preLoginVC.textFieldEmail)
//        preLoginVC.checkEmail()
//        preLoginVM.checkEmail(textFieldEmail: preLoginVC.textFieldEmail, buttonGo: preLoginVC.buttonGo)
        preLoginVC.textFieldDidEndEditing(preLoginVC.textFieldEmail)
        preLoginVC.buttonGo.sendActions(for: .touchUpInside)
        preLoginVC.goToLoginScreen()
        XCTAssertTrue(mock.getEmailWasCalled)
        expectation.fulfill()
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testInvalidEmail() {
        preLoginVC.textFieldEmail.text = "usuario.com"
//        preLoginVC.checkEmail()
        preLoginVC.textFieldDidEndEditing(preLoginVC.textFieldEmail)
        preLoginVM.startAplication(labelEmail: preLoginVC.labelEmail, stackInvalidEmail: preLoginVC.stackInvalidEmail)
        preLoginVC.textFieldDidEndEditing(preLoginVC.textFieldEmail)
        preLoginVM.checkEmail(textFieldEmail: preLoginVC.textFieldEmail, buttonGo: preLoginVC.buttonGo)
        XCTAssertFalse(preLoginVM.stackInvalidEmail.isHidden)
        
    }
    
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        preLoginVC = (navigationController.topViewController as! PreLoginViewController)
        
        UIApplication.shared.keyWindow!.rootViewController = preLoginVC
        let _ = preLoginVC.view
        
        
    }
    
    override func tearDown() {
        preLoginVC = nil
        super.tearDown()
    }

    

}
