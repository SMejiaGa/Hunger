//
//  RecoveryService.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/11/21.
//

import Foundation
import Alamofire

final class RecoveryService {
    
    func postRecovery(
        email: Email,
        onFinished: @escaping (String) -> Void
    ) {
       
        AF.request(
            Endpoints.postRecovery.url,
            method: .post,
            parameters: email,
            headers: nil
        ).responseDecodable { (res: DataResponse<RecoveryResponse, AFError>) in
            onFinished(res.value?.message ?? "")
        }
        
    }
}
