//
//  APIManager.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 17/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

//struct NewUsers: Decodable {
//    var email: String = ""
//    var password:String  = ""
//    var completeName: String = ""
//    var username: String = ""
//    var registrationStatus: String = "INEXISTENT"
//}

struct UsersInfo: Decodable {
    //var email: String = ""
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
            print("Error: " + error.localizedDescription)
            let newUser = UsersInfo()
            completion(newUser)
        }
        

    }

    func updateRegistrationStatus(email: String, password: String, completeName: String, username: String, registrationStatus: String) {
        let parameters = [
            "email": email,
            "password": password,
            "completeName": completeName,
            "username": username,
            "registrationStatus": registrationStatus,
            ] as [String : Any]
        
        let url = baseURL + APIManager.getUsersEndpoint + String(email)
        manager.put(url, parameters: parameters, success: { (task, responseObject) in
            print(responseObject.debugDescription)
        }) { (task, error) in
            print(error.localizedDescription)
        }
    }

    
    func createNewUser(email: String, password: String, completeName: String, username: String, registrationStatus: String) {
        let url = baseURL + APIManager.getUsersEndpoint + key
        
        let parameters = [
            "email": email,
            "password": password,
            "completeName": completeName,
            "username": username,
            "registrationStatus": registrationStatus
            ] as [String : Any]
        
        manager.post(url, parameters: parameters, progress: nil, success: { (task, responseObject) in
            print(responseObject.debugDescription)
        }) { (task, error) in
            print(error.localizedDescription)
        }

    }
    
}
