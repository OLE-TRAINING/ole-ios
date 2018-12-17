//
//  ValidateTokenTests.swift
//  LocadoraOleTrainingTests
//
//  Created by Lorena Rodrigues on 17/12/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import XCTest
import InstantMock

@testable import LocadoraOleTraining
class ValidateTokenTests: XCTestCase {

    var validateTokenVC: ValidateTokenViewController!
    var validateTokenVM = ValidateTokenViewModel()
    
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
        validateTokenVC.textFieldToken.text = "s4c3ss"
        validateTokenVC.textFieldDidEndEditing(validateTokenVC.textFieldToken)
        XCTAssertEqual(validateTokenVC.emailUser, "usuario@inexistent.com")
        mock.it.expect().call(
            mock.it.stub().call(
                mock.validateToken(textFieldToken: validateTokenVC.textFieldToken, email: validateTokenVC.emailUser, completion: { (result) in
                    
                })
            )
        )
        XCTAssertTrue(mock.getMockValidateTokenServiceCalled)
        validateTokenVC.buttonValidate.sendActions(for: .touchUpInside)
    }
    
    func testInvalidToken() {
        validateTokenVC.textFieldToken.text = "aaa"
        validateTokenVC.textFieldDidEndEditing(validateTokenVC.textFieldToken)
    }
    
    func testResendToken() {
        let mock = MockAPIManager()
        
        validateTokenVM.stackViewInvalidCode = validateTokenVC.stackInvalidCode
        mock.it.expect().call(
            mock.it.stub().call(
                mock.generateToken(email: validateTokenVC.emailUser, completion: { (result) in
                    
                })
            )
        )
        validateTokenVC.buttonSendAgain.sendActions(for: .touchUpInside)
        XCTAssertTrue(mock.getMockGenerateTokenServiceCalled)
        
    }
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "validarToken")
        validateTokenVC = (navigationController as! ValidateTokenViewController)
        validateTokenVC.emailUser = "usuario@inexistent.com"
        
        UIApplication.shared.keyWindow!.rootViewController = validateTokenVC
        let _ = validateTokenVC.view
    }

    override func tearDown() {
        validateTokenVC = nil
    }


}
