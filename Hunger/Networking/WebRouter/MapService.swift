//
//  MapService.swift
//  Hunger
//
//  Created by Sebastian Mejia on 14/11/21.
//

import Foundation
import Alamofire

typealias MapPointerServiceResult = ([MapPointer], Bool) -> Void

final class MapService{
    
    func getRestaurantsLocation(onFinished: @escaping MapPointerServiceResult) {
        
        var errorExist: Bool = false
   
        AF.request(Endpoints.getRestaurantLocations.url).responseDecodable{ (res: DataResponse<[MapPointer], AFError>) in
            if res.error != nil{
                errorExist = true
            }
            let responseFromService = res.value ?? []
            onFinished(responseFromService, errorExist)
        }
    }
}
