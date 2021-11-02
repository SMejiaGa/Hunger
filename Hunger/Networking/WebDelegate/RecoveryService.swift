//
//  RecoveryService.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/11/21.
//

import Foundation
import Alamofire

class RecoveryService {
    
    private let serverEndpoint = "https://hunger-swift-api.herokuapp.com/api/v1"
    
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
