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

struct Genre : Decodable {
    var id: Int = 0
    var name: String? = nil
}

struct FilmGenre: Decodable {
    var genre:String? = nil
    var genres = [Genre]()
}

struct Film: Decodable {
    var id: Int = 0
    var posterId: String? = nil
    var bannerId: String? = nil
    var voteAverage: Double = 0.0
    var title: String? = nil
    var year: Int = 0
    var genreNames = [String]()
    var runtime: String? = nil
    var overview: String? = nil
    var favorit: Bool = false
    var price: Double = 0.0
    var acquired: Bool = false
}


class APIManager: NSObject {
    let baseURL = "https://ole.dev.gateway.zup.me/client-training/v1"
    static let getUsersEndpoint = "/users"
    static let getTokensEndpoint = "/tokens"
    static let getValidateEndpoint = "/validate"
    static let getFilmGenres = "/genres"
    static let getMovies = "/movies"
    static let getImage = "/image"
    let key = "?gw-app-key=593c3280aedd01364c73000d3ac06d76"
    let xMockKey = "x-mock"
    let xAccessTokenKey = "x-access-token"
    let xUID = "x-uid"
    let authorizationKey = "Authorization"
    
    var bearerToken = ""
    
    static let shared = APIManager()
    
    let manager = AFHTTPSessionManager()

    
    
    func getUserWithEmail(_ email: String, completion: @escaping (UsersInfo?) -> Void)  {
        let url = baseURL + APIManager.getUsersEndpoint + "/" + String(email) + key

        
        self.get(url: url, success: { (task, responseObject) in
            let dataJson = try! JSONSerialization.data(withJSONObject: responseObject as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
            let user = try?
                JSONDecoder().decode(UsersInfo.self, from: dataJson)
            completion(user)
        }) { (task, error) in
            let newUser = UsersInfo()
            ValidateForm.showAlertError()
            completion(newUser)
        }

    }

    
    func generateToken(email: String, completion: @escaping(Bool) -> Void) {
        let url = baseURL + APIManager.getTokensEndpoint + "/" + String(email) + key
        
        self.put(url: url, parameters: nil, success: { (task, responseObject) in
            completion(true)
        }) { (task, error) in
            completion(false)
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

        self.post(url: url, parameters: parameters, success: { (task, responseObject) in
            completion(true)
        }) { (task, error) in
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

        self.post(url: url, parameters: parameters, success: { (task, responseObject) in
            completion(true)
        }) { (task, error) in
            completion(false)
            ValidateForm.showAlertError()
        }
        

    }
    
    func authenticateUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        let url = baseURL + APIManager.getUsersEndpoint + APIManager.getValidateEndpoint + key
        
        let parameters = [
            "email": email,
            "password": password
            ] as [String : Any]
        
        self.post(url: url, parameters: parameters, success: { (task, responseObject) in
            completion(true)
        }) { (task, error) in
            completion(false)
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

        //manager.requestSerializer.setValue("", forHTTPHeaderField: xMockKey)
        self.post(url: url, parameters: parameters, success: { (task, responseObject) in
            completion(true)
        }) { (task, error) in
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
        
        manager.requestSerializer.setValue("success", forHTTPHeaderField: xMockKey)
        self.put(url: url, parameters: parameters, success: { (task, responseObject) in
            completion(true)
        }) { (task, error) in
            completion(false)
            ValidateForm.showAlertError()
        }

    }
    
    func getFilmGenres(completion: @escaping (FilmGenre?) -> Void) {
        let url = baseURL + APIManager.getFilmGenres + key
        
        manager.requestSerializer.setValue("success", forHTTPHeaderField: xMockKey)
        setAuthorizationToken(bearerToken: self.bearerToken)
        self.get(url: url, success: { (task, responseObject) in
            let dataJson = try! JSONSerialization.data(withJSONObject: responseObject as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
            let genre = try?
                JSONDecoder().decode(FilmGenre.self, from: dataJson)
            completion(genre)
        }) { (task, error) in
            let genre = FilmGenre()
            //ValidateForm.showAlertError()
            print(error.debugDescription)
            completion(genre)
        }
    }
    
    func getFilmsByGenre(id: Int, completion: @escaping ([Film]) -> Void) {
        let url = baseURL + APIManager.getFilmGenres + "/\(id)" + APIManager.getMovies + key
        
        // trocar o valor do xmocqando o serviço real for chamado
        //manager.requestSerializer.setValue("action_genre", forHTTPHeaderField: xMockKey)
        setAuthorizationToken(bearerToken: self.bearerToken)
        self.get(url: url, success: { (task, responseObject) in
            let dataJson = try! JSONSerialization.data(withJSONObject: responseObject as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
            do {
                let films = try
              JSONDecoder().decode([Film].self, from: dataJson)
                //print("Sucesso ao pegar filmes por genro: " + responseObject.debugDescription)
                completion(films)
            } catch {
                //print(error.localizedDescription)
                completion([])
            }
            
            
        }) { (task, error) in
            let film = [Film]()
            //print("Erro ao pegar filmes por genero: " + error.debugDescription)
            //ValidateForm.showAlertError()
            completion(film)
        }
        
    }
    
    func getImagePoster(id: String, size: String) -> URL? {
        let url = baseURL + APIManager.getMovies + "/\(id)" + APIManager.getImage + "/\(size)" + key
        
        //setAuthorizationToken(bearerToken: self.bearerToken)
        manager.get(url, parameters: nil, progress: nil, success: { (task, responseObject) in
            
        }) { (task, error) in
            
        }
        
        return URL(string: url)
    }
    
    
    private func setAuthorizationToken(bearerToken: String) {
        manager.requestSerializer.setValue("Bearer \(bearerToken)", forHTTPHeaderField: authorizationKey)
    }
    
    
    private func getHeaders(responseObject: Any?) {
        if let responseObject = responseObject as? HTTPURLResponse {
            let accessToken = responseObject.allHeaderFields [self.xAccessTokenKey]
            //print("accessToken: \(accessToken)")
            //let xUID = responseObject.allHeaderFields[self.xUID]
            self.bearerToken = accessToken as? String ?? ""
        }
    }

    
    //criar um novo método get que encapsule a função de deserialização do arquivo json
    private func get(url: String, success: @escaping (URLSessionDataTask?, Any?) -> Void, failure: @escaping (URLSessionDataTask?, Error?) -> Void) {
        
        
        manager.get(url, parameters: nil, progress: nil, success: { [weak self] (task, responseObject) in
            self?.getHeaders(responseObject: task.response)
            success(task, responseObject)
        }) { [weak self] (task, error) in
            self?.getHeaders(responseObject: task?.response)
            ValidateForm.showAlertSessionExpired()
            failure(task, error)
        }
    }
    
    private func post(url: String, parameters: [String : Any], success: @escaping (URLSessionDataTask?, Any?) -> Void, failure: @escaping (URLSessionDataTask?, Error?) -> Void) {
        manager.post(url, parameters: parameters, progress: nil, success: { [weak self] (task, responseObject) in
            self?.getHeaders(responseObject: task.response)
            success(task, responseObject)
        }) { [weak self] (task, error) in
            self?.getHeaders(responseObject: task?.response)
            ValidateForm.showAlertSessionExpired()
            failure(task, error)
        }
    }
    
    private func put(url: String, parameters: [String : Any]?, success: @escaping (URLSessionDataTask?, Any?) -> Void, failure: @escaping (URLSessionDataTask?, Error?) -> Void) {
        manager.put(url, parameters: parameters, success: { [weak self] (task, responseObject) in
            self?.getHeaders(responseObject: task.response)
            success(task, responseObject)
        }) { [weak self] (task, error) in
            self?.getHeaders(responseObject: task?.response)
            ValidateForm.showAlertSessionExpired()
            failure(task, error)
        }
    }
}


