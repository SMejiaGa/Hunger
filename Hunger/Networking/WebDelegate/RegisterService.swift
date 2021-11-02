//
//  RegisterService.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/11/21.
//

import Foundation
import Alamofire

class RegisterService {
    
    private let serverEndpoint = "https://hunger-swift-api.herokuapp.com/api/v1"
    
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
}
