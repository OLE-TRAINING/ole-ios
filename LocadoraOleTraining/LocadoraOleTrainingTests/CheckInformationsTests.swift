//
//  CheckInformationsTests.swift
//  LocadoraOleTrainingTests
//
//  Created by Lorena Rodrigues on 17/12/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import XCTest
import InstantMock

@testable import LocadoraOleTraining

class CheckInformationsTests: XCTestCase {
    
    var checkInformationsVC: CheckInformationsViewController!
    var checkInformationsVM = CheckInformationsViewModel()
    
    class MockAPIManager: APIManager, MockDelegate {
        private let mock = Mock()
        var getMockGetUsernameServiceCalled = false
        var getMockCheckUsernameServiceCalled = false
        var getMockGenerateTokenServiceCalled = false
        var resultEmailRegistered = UsersInfo(email: "usuario@registered.com", completeName: "usuario registrado" , username: "novousuario", registrationStatus: "REGISTERED")
        
        var it: Mock {
            return mock
        }
        
        override func getUserWithEmail(_ email: String, completion: @escaping (UsersInfo?) -> Void) {
            getMockGetUsernameServiceCalled = true
            completion(resultEmailRegistered)
        }
        
        override func confirmUserInformation(email: String, username: String, completion: @escaping (Bool?) -> Void) {
            getMockCheckUsernameServiceCalled = true
            completion(true)
        }
        
        override func generateToken(email: String, completion: @escaping (Bool) -> Void) {
            getMockGenerateTokenServiceCalled = true
            completion(true)
        }
       
    }
    
    func testUsername() {
        let mock = MockAPIManager()
        checkInformationsVC.textFieldUsername.text = "novousuario"
        XCTAssertEqual(checkInformationsVC.labelEmail.text!, "usuario@registered.com")
        checkInformationsVC.textFieldDidEndEditing(checkInformationsVC.textFieldUsername)
        mock.it.expect().call(
            mock.it.stub().call(
                mock.getUserWithEmail(checkInformationsVC.labelEmail.text!, completion: { (user) in
                    if self.checkInformationsVC.textFieldUsername.text! == user?.username {
                        mock.it.stub().call(
                            mock.confirmUserInformation(email: self.checkInformationsVC.labelEmail.text!, username: self.checkInformationsVC.textFieldUsername.text!, completion: { (result) in
                                if result! {
                                    mock.it.stub().call(
                                        mock.generateToken(email: self.checkInformationsVC.labelEmail.text!, completion: { (result) in
                                            
                                        })
                                    )
                                }
                            })
                        )
                    }
                })
            )
        )
        
        checkInformationsVC.buttonGo.sendActions(for: .touchUpInside)
        XCTAssertTrue(mock.getMockCheckUsernameServiceCalled)
        XCTAssertTrue(mock.getMockGetUsernameServiceCalled)
        XCTAssertTrue(mock.getMockGenerateTokenServiceCalled)
    }
    
    func testInvalidUsername() {
        checkInformationsVC.textFieldUsername.text = "novousuario&"
        checkInformationsVC.textFieldDidEndEditing(checkInformationsVC.textFieldUsername)
    }

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "verificaInformacoes")
        checkInformationsVC = (navigationController as! CheckInformationsViewController)
        checkInformationsVC.emailUser = "usuario@registered.com"
        
        UIApplication.shared.keyWindow!.rootViewController = checkInformationsVC
        let _ = checkInformationsVC.view
    }

    override func tearDown() {
        checkInformationsVC = nil
    }
    
    

}
