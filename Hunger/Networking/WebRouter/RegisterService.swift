//
//  RegisterService.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/11/21.
//

import Foundation
import Alamofire

final class RegisterService {
    
    func postRegister(
        user: User,
        onFinished: @escaping (Bool) -> Void
    ) {
    
        AF.request(
            Endpoints.postResigterUser.url,
            method: .post,
            parameters: user,
            headers: nil
        ).responseDecodable { (res: DataResponse<UserResponse, AFError>) in
            onFinished(res.value?.sucess == true)
        }
    }
}
