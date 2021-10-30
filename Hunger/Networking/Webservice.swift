//
//  Webservice.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import Foundation
import Alamofire

final class WebService {
    
    //MARK: -Properties
    private let serverEndpoint = "https://hunger-swift-api.herokuapp.com/api/v1"
    
    func getRestaurants(onFinished: @escaping ([Restaurant], Bool) -> Void) {
        var errorExist: Bool = false
        let restaurantURL = "\(serverEndpoint)\(Endpoints.getRestaurants.url)"
        AF.request(restaurantURL).responseDecodable{ (res: DataResponse<[Restaurant], AFError>) in
            if res.error != nil{
                errorExist = true
            }
            let responseFromService = res.value ?? []
            onFinished(responseFromService, errorExist)
        }
    }
    
    func postLogin(
        user: User,
        onFinished: @escaping (Bool) -> Void
    ) {
        let loginURL =  "\(serverEndpoint)\(Endpoints.postLoginUser.url)"
        
        AF.request(
            loginURL,
            method: .post,
            parameters: user,
            headers: nil
        ).responseDecodable { (res: DataResponse<UserResponse, AFError>) in
            onFinished(res.value?.sucess == true)
        }
    }
    
    
    func postRegister(
        user: User,
        onFinished: @escaping (Bool) -> Void
    ) {
        let registerURL =  "\(serverEndpoint)\(Endpoints.postResigterUser.url)"
        
        AF.request(
            registerURL,
            method: .post,
            parameters: user,
            headers: nil
        ).responseDecodable { (res: DataResponse<UserResponse, AFError>) in
            onFinished(res.value?.sucess == true)
        }
    }
    func postRecovery(
        email: Email,
        onFinished: @escaping (String) -> Void
    ) {
        let registerURL =  "\(serverEndpoint)\(Endpoints.postRecovery.url)"
        
        AF.request(
            registerURL,
            method: .post,
            parameters: email,
            headers: nil
        ).responseDecodable { (res: DataResponse<RecoveryResponse, AFError>) in
            onFinished(res.value?.message ?? "")
        }
        
    }
}

