//
//  APIManager.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 17/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

struct Users: Decodable {
    var email: String = ""
    var password:String  = ""
    var completeName: String = ""
    var username: String = ""
    var registrationStatus: String = "UNEXISTENT"
    var id: String = ""
}

class APIManager: NSObject {
    let baseURL = "http://localhost:3000"
    static let getUsersEndpoint = "/users/"
    
    static let shared = APIManager()
    
    let manager = AFHTTPSessionManager()

    
    
    func getAllUsers()  {
        
        let url = baseURL + APIManager.getUsersEndpoint
        manager.get(url, parameters: nil, progress: nil, success: { (task, responseObject) in
            print(responseObject!)
        }) { (task, error) in
            print("Error: ", error)
        }
    }
    
    func getUserWithEmail(_ email: String, completion: @escaping (Users?) -> Void)  {
        let url = baseURL + APIManager.getUsersEndpoint  + String(email)

        
        manager.get(url, parameters: nil, progress: nil ,success: { (task, responseObject) in
            //print(responseObject.debugDescription)
            let dataJson = try! JSONSerialization.data(withJSONObject: responseObject as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
            let user = try?
                JSONDecoder().decode(Users.self, from: dataJson)
            completion(user)
            
        }) { (task, error) in
            //print("Error: " + error.localizedDescription)
            let newUser = Users()
            completion(newUser)
        }
        

    }

    func atualizarRegistrationStatus(email: String, password: String, completeName: String, username: String, registrationStatus: String) {
        let parameters = [
            "email": email,
            "password": password,
            "completeName": completeName,
            "username": username,
            "registrationStatus": registrationStatus,
            "id": email
            ] as [String : Any]
        
        let url = baseURL + APIManager.getUsersEndpoint + String(email)
        manager.put(url, parameters: parameters, success: { (task, responseObject) in
            print(responseObject.debugDescription)
        }) { (task, error) in
            print(error.localizedDescription)
        }
    }
    
    func verificaSenhaLogin(senha: String, email: String) -> Bool{
        var flag = false
        getUserWithEmail(email, completion: { (user: Users?) in
            if senha == user?.password{
                flag = true
            }
        })
        return flag
    }
    
    func postUser(parameters: [String:Any] ) {
        let url = baseURL + APIManager.getUsersEndpoint
        
        manager.post(url, parameters: parameters, progress: nil, success: { (task, responseObject) in
            print(responseObject.debugDescription)
        }) { (task, error) in
            print(error.localizedDescription)
        }
    }
    
    func criaNovoUsuario(email: String, password: String, completeName: String, username: String, registrationStatus: String) -> [String:Any] {
        let parameters = [
            "email": email,
            "password": password,
            "completeName": completeName,
            "username": username,
            "registrationStatus": registrationStatus,
            "id": email
            ] as [String : Any]
        
        return parameters

    }
    
}
