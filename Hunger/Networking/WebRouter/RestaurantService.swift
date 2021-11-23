//
//  RestaurantService.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/11/21.
//

import Foundation
import Alamofire

typealias RestaurantServiceResult = ([Restaurant], Bool) -> Void
typealias RestaurantDetailResult = (RestaurantDetail, Bool) -> Void

final class RestaurantService {
    
    func getRestaurants(onFinished: @escaping RestaurantServiceResult) {
        
        var errorExist: Bool = false
   
        AF.request(Endpoints.getRestaurants.url).responseDecodable { (res: DataResponse<[Restaurant], AFError>) in
            if res.error != nil {
                errorExist = true
            }
            let responseFromService = res.value ?? []
            onFinished(responseFromService, errorExist)
        }
    }
    
    func getRestaurantDetail(onFinished: @escaping RestaurantDetailResult, getDetail: Int) {
        
        var errorExist: Bool = false
   
        AF.request("\(Endpoints.getRestaurantDetail.url)\(getDetail)").responseDecodable { (res: DataResponse< RestaurantDetail, AFError>) in
            if res.error != nil {
                errorExist = true
            }
            if let responseFromService = res.value {
                onFinished(responseFromService, errorExist)
            }
            
        }
    }
}
