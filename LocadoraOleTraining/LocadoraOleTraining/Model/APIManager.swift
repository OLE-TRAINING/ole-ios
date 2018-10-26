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

    
//    func getAllPosts() {
//
//        let url = baseURL + APIManager.getUsersEndpoint
//        manager.get(url, parameters: nil, progress: nil, success: { (task, responseObject) in
//            print(responseObject!)
//        }) { (task, error) in
//            print("Error: ", error)
//        }
//
//    }
    
    func getUserWithEmail(_ email: String, completion: @escaping (UsersInfo?) -> Void)  {
        let url = baseURL + APIManager.getUsersEndpoint + "/" + String(email) + key

        manager.get(url, parameters: nil, progress: nil ,success: { (task, responseObject) in
            //print(responseObject.debugDescription)
            let dataJson = try! JSONSerialization.data(withJSONObject: responseObject as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
            let user = try?
                JSONDecoder().decode(UsersInfo.self, from: dataJson)
            completion(user)
            
        }) { (task, error) in
            print("Error getUserWithEmail: " + error.localizedDescription)
            let newUser = UsersInfo()
            ValidateForm.showAlertError()
            completion(newUser)
        }
        

    }

//    func updateRegistrationStatus(email: String, password: String, completeName: String, username: String, registrationStatus: String) {
//        let parameters = [
//            "email": email,
//            "password": password,
//            "completeName": completeName,
//            "username": username,
//            //"registrationStatus": registrationStatus,
//            ] as [String : Any]
//        
//        let url = baseURL + APIManager.getUsersEndpoint + String(email)
//        manager.put(url, parameters: parameters, success: { (task, responseObject) in
//            print(responseObject.debugDescription)
//        }) { (task, error) in
//            print(error.localizedDescription)
//        }
//    }
    
    func generateToken(email: String) {
        let url = baseURL + APIManager.getTokensEndpoint + "/" + String(email) + key
        
        manager.put(url, parameters: nil, success: { (task, responseObject) in
            print("Response generateToken: " + responseObject.debugDescription)
        }) { (task, error) in
            print("Error generateToken: " + error.localizedDescription)
            ValidateForm.showAlertError()
        }
    }
    
    func validateToken(textFieldCode: UITextField, email: String, completion: @escaping(Bool) -> Void) {
        guard let token = textFieldCode.text else { return }
        
        let url = baseURL + APIManager.getTokensEndpoint + "/" + email + "/" + token + key

        let parameters = [
            "email": email,
            "token": token
            ] as [String : Any]
        
        manager.post(url, parameters: parameters, progress: nil, success: { (task, responseObject) in
            print("Response validateToken:" + responseObject.debugDescription )
            completion(true)
        }) { (task, error) in
            print("Error validateToken:" + error.localizedDescription)
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
                print("Response createNewUser:" + responseObject.debugDescription)
                completion(true)
            }) { (task, error) in
                print("Error createNewUser:" + error.localizedDescription)
                ValidateForm.showAlertError()
                completion(false)
            }
    }
    
    func authenticateUser(email: String, textFieldPassword: UITextField) {
        let url = baseURL + APIManager.getUsersEndpoint + "/validate" + key
        guard let password = textFieldPassword.text else {
            return
        }
        
        let parameters = [
            "email": email,
            "password": password
            ] as [String : Any]
        
        manager.post(url, parameters: parameters, progress: nil, success: { (task, responseObject) in
            print("Response authenticateUser:" + responseObject.debugDescription)
        }) { (task, error) in
            print("Error authenticateUser:" + error.localizedDescription)
            ValidateForm.showAlertError()
        }
    }
    
}
