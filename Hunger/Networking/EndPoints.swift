//
//  EndPoints.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import Foundation

enum Endpoints {
    case getRestaurants
    case postLoginUser
    case postResigterUser
    case postRecovery
    case getRestaurantLocations
    
    case getAboutUsText
    
    var base: String {
        "https://hunger-swift-api.herokuapp.com/api/v1"
    }
    
    var url: String {
        switch self {
        case .getRestaurants:
            return "\(base)/restaurants"
            
        case.getRestaurantLocations:
            return "\(base)/restaurants/locations"
            
        case .postLoginUser:
            return "\(base)/login"
        
        case .postResigterUser:
            return "\(base)/register"
            
        case .postRecovery:
            return "\(base)/recovery"
            
        case .getAboutUsText:
            return "\(base)/commons/legal"
        }
    }
}
