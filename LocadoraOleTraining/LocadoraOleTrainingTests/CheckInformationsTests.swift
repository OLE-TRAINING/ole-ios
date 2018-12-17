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
        var getMockCheckUsernameServiceCalled = false
        var resultEmailRegistered = UsersInfo(email: "usuario@registered.com", completeName: "usuario registrado" , username: "novousuario", registrationStatus: "REGISTERED")
        
        var it: Mock {
            return mock
        }
        
        override func getUserWithEmail(_ email: String, completion: @escaping (UsersInfo?) -> Void) {
            getMockCheckUsernameServiceCalled = true
            completion(resultEmailRegistered)
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
                    
                })
            )
        )
        
        checkInformationsVC.buttonGo.sendActions(for: .touchUpInside)
        XCTAssertTrue(mock.getMockCheckUsernameServiceCalled)
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
