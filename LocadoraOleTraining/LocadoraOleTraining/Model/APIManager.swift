//
//  APIManager.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 17/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit


struct UsersInfo: Decodable {
    var email: String? = nil
    var completeName: String? = nil
    var username: String? = nil
    var registrationStatus: String = "INEXISTENT"
}



class APIManager: NSObject {
    let baseURL = "https://ole.dev.gateway.zup.me/client-training/v1"
    static let getUsersEndpoint = "/users"
    static let getTokensEndpoint = "/tokens"
    let key = "?gw-app-key=593c3280aedd01364c73000d3ac06d76"
    
    static let shared = APIManager()
    
    let manager = AFHTTPSessionManager()

    
    
    func getUserWithEmail(_ email: String, completion: @escaping (UsersInfo?) -> Void)  {
        let url = baseURL + APIManager.getUsersEndpoint + "/" + String(email) + key

        manager.get(url, parameters: nil, progress: nil ,success: { (task, responseObject) in
            //print(responseObject.debugDescription)
            let dataJson = try! JSONSerialization.data(withJSONObject: responseObject as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
            let user = try?
                JSONDecoder().decode(UsersInfo.self, from: dataJson)
            completion(user)
            
        }) { (task, error) in
            //print("Error getUserWithEmail: " + error.localizedDescription)
            let newUser = UsersInfo()
            ValidateForm.showAlertError()
            completion(newUser)
        }

    }

    
    func generateToken(email: String, completion: @escaping(Bool) -> Void) {
        let url = baseURL + APIManager.getTokensEndpoint + "/" + String(email) + key
        
        manager.put(url, parameters: nil, success: { (task, responseObject) in
            completion(true)
            //print("Response generateToken: " + responseObject.debugDescription)
        }) { (task, error) in
            completion(false)
            //print("Error generateToken: " + error.localizedDescription)
            ValidateForm.showAlertError()
        }
    }
    
    func validateToken(textFieldCode: UITextField, email: String, completion: @escaping(Bool) -> Void) {
        guard let token = textFieldCode.text else { return }
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        let url = baseURL + APIManager.getUsersEndpoint + "/" + email + "/register/" + token + key

        let parameters = [
            "email": email,
            "token": token
            ] as [String : Any]
        
        manager.post(url, parameters: parameters, progress: nil, success: { (task, responseObject) in
            //print("Response validateToken:" + responseObject.debugDescription )
            completion(true)
        }) { (task, error) in
            //print("Error validateToken:" + error.localizedDescription)
            ValidateForm.showAlertError()
            completion(false)
        }
    }
    
    
    func createNewUser(email: String, password: String, completeName: String, username: String,  completion: @escaping (Bool?) -> Void) {
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        let url = baseURL + APIManager.getUsersEndpoint + key
        
            let parameters = [
                "email": email,
                "password": password,
                "completeName": completeName,
                "username": username
                ] as [String : Any]
            
            manager.post(url, parameters: parameters, progress: nil, success: { (task, responseObject) in
                //print("Response createNewUser:" + responseObject.debugDescription)
                completion(true)
            }) { (task, error) in
                //print("Error createNewUser:" + error.localizedDescription)
                ValidateForm.showAlertError()
                completion(false)
            }
    }
    
    func authenticateUser(email: String, password: String) {
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        let url = baseURL + APIManager.getUsersEndpoint + "/validate" + key
                
        let parameters = [
            "email": email,
            "password": password
            ] as [String : Any]
        
        manager.post(url, parameters: parameters, progress: nil, success: { (task, responseObject) in
            //print("Response authenticateUser:" + responseObject.debugDescription)
        }) { (task, error) in
            //print("Error authenticateUser:" + error.localizedDescription)
            ValidateForm.showAlertError()
        }
    }
    
    func confirmUserInformation(email: String, username: String, completion: @escaping (Bool?) -> Void) {
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        
        let url = baseURL + APIManager.getUsersEndpoint + "/confirm-data" + key

        
        let parameters = [
            "username": username,
            "email": email
            ] as [String : Any]

        manager.requestSerializer.setValue("", forHTTPHeaderField: "x-mock")
        manager.post(url, parameters: parameters, progress: nil,  success: { (task, responseObject) in
            //print("Response confirmUserInformation:" + responseObject.debugDescription)
            completion(true)
        }) { (task, error) in
            //print("Error confirmUserInformation:" + error.localizedDescription)
            completion(false)
            ValidateForm.showAlertError()
        }
        
    }
    
    func changePassword(email: String, confirmationToken: String, newPassword: String, newPasswordConfirmation: String, completion: @escaping(Bool) -> Void ) {
        let url = baseURL + APIManager.getUsersEndpoint + "/password" + key
        
        let parameters = [
            "email" : email,
            "confirmationToken" : confirmationToken,
            "newPassword" : newPassword,
            "newPasswordConfirmation" : newPasswordConfirmation
        ] as [String : Any]
        
        manager.requestSerializer.setValue("success", forHTTPHeaderField: "x-mock")
        manager.put(url, parameters: parameters, success: { (task, responseObject) in
            completion(true)
            print("Response changePassword: " + responseObject.debugDescription)
        }) { (task, error) in
            print("Error changePassword: " + error.localizedDescription)
            completion(false)
            ValidateForm.showAlertError()
        }
    }
    
}
