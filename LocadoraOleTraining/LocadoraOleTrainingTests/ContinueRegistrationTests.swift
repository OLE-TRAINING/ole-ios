//
//  ContinueRegistrationTests.swift
//  LocadoraOleTrainingTests
//
//  Created by Lorena Rodrigues on 17/12/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import XCTest
import InstantMock

@testable import LocadoraOleTraining

class ContinueRegistrationTests: XCTestCase {
    
    var continueRegistrationVC: ContinueRegistration!
    var continueRegistrationVM = ContinueRegistrationViewModel()
    
    class MockAPIManager: APIManager, MockDelegate {
        private let mock = Mock()
        var getMockValidateTokenServiceCalled = false
        var getMockGenerateTokenServiceCalled = false
        
        var it: Mock {
            return mock
        }
        
        override func validateToken(textFieldToken: UITextField, email: String, completion: @escaping (Bool) -> Void) {
            getMockValidateTokenServiceCalled = true
            completion(true)
        }
        
        override func generateToken(email: String, completion: @escaping (Bool) -> Void) {
            getMockGenerateTokenServiceCalled = true
            completion(true)
        }
    }
    
    func testToken() {
        let mock = MockAPIManager()
        continueRegistrationVC.textFieldToken.text = "s4c3ss"
        XCTAssertEqual(continueRegistrationVC.emailUser, "usuario@pending.com")
        continueRegistrationVC.textFieldDidEndEditing(continueRegistrationVC.textFieldToken)
        continueRegistrationVC.textFieldDidEndEditing(continueRegistrationVC.textFieldToken)
        mock.it.expect().call(
            mock.it.stub().call(
                mock.validateToken(textFieldToken: continueRegistrationVC.textFieldToken, email: continueRegistrationVC.emailUser!, completion: { (result) in
                    
                })
            )
        )
        
        continueRegistrationVC.buttonValidate.sendActions(for: .touchUpInside)
        XCTAssertTrue(mock.getMockValidateTokenServiceCalled)
    }
    
    func testInvalidToken() {
        continueRegistrationVC.textFieldToken.text = "aaa"
        continueRegistrationVC.textFieldDidEndEditing(continueRegistrationVC.textFieldToken)
        XCTAssertFalse(continueRegistrationVM.checkToken(textFieldToken: continueRegistrationVC.textFieldToken))
    }
    
    func testResendToken() {
        let mock = MockAPIManager()
        
        mock.it.expect().call(
            mock.it.stub().call(
                mock.generateToken(email: continueRegistrationVC.emailUser!, completion: { (result) in
                    
                })
            )
        )
        continueRegistrationVC.buttonSend.sendActions(for: .touchUpInside)
        XCTAssertTrue(mock.getMockGenerateTokenServiceCalled)
        
    }

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "continuarCadastro")
        continueRegistrationVC = (navigationController as! ContinueRegistration)
        continueRegistrationVC.emailUser = "usuario@pending.com"
        
        UIApplication.shared.keyWindow!.rootViewController = continueRegistrationVC
        let _ = continueRegistrationVC.view
    }

    override func tearDown() {
        continueRegistrationVC = nil
    }

    

}
