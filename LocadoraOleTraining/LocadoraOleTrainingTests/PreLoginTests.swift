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
        var result = UsersInfo(email: "usuario@novo.com", completeName: nil, username: nil, registrationStatus: "INEXISTENT")
        
        private let mock = Mock()
        
        var it: Mock {
            return mock
        }
        
        
        override func getUserWithEmail(_ email: String, completion: @escaping (UsersInfo?) -> Void) {
            getEmailWasCalled = true
            completion(result)
            mock.call(email, completion )
        }
        
        
    }
    
    func testGetEmail() {
        
        let expectation = XCTestExpectation(description: "Teste de cadastro inexistente")
        let mock = MockAPIManager()
        preLoginVC.textFieldEmail.text = "usuario@novo.com"
        
        mock.it.stub().call(
            mock.getUserWithEmail(Arg.any(), completion: { (result: UsersInfo?) in

            })
        ).andReturn(true)

        self.preLoginVM.goToNextScreen(textFieldEmail: self.preLoginVC.textFieldEmail , button: self.preLoginVC.buttonGo, loading: self.preLoginVC.loading) { (result: String?) in
            XCTAssertTrue(mock.getEmailWasCalled)
        }
        
        //        viewController.buttonGo.sendActions(for: .touchUpInside)
        wait(for: [expectation], timeout: 10.0)
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
