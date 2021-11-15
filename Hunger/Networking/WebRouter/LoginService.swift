//
//  LoginService.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/11/21.
//

import Foundation
import Alamofire

final class LoginService {
    
    private let serverEndpoint = "https://hunger-swift-api.herokuapp.com/api/v1"
    
    func postLogin(
        user: User,
        onFinished: @escaping (Bool) -> Void
    ) {
    
        AF.request(
            Endpoints.postLoginUser.url,
            method: .post,
            parameters: user,
            headers: nil
        ).responseDecodable { (res: DataResponse<UserResponse, AFError>) in
            onFinished(res.value?.sucess == true)
        }
    }
}
