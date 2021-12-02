//
//  MapService.swift
//  Hunger
//
//  Created by Sebastian Mejia on 14/11/21.
//

import Foundation
import Alamofire

typealias MapPointerServiceResult = ([RestaurantLocation], Bool) -> Void

final class MapService {
    
    func getRestaurantsLocation(onFinished: @escaping MapPointerServiceResult) {
        
        AF.request(Endpoints.getRestaurantLocations.url).responseDecodable {(res: DataResponse<[RestaurantLocation], AFError>) in
            
            let responseFromService = res.value ?? []
            onFinished(responseFromService, res.error != nil)
        }
    }
}
