//
//  RestaurantService.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/11/21.
//

import Foundation
import Alamofire

class RestaurantService {
    
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
}
