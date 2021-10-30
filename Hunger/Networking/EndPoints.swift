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
    
    var url: String {
        switch self {
        case .getRestaurants:
            return "/restaurants"
            
        case .postLoginUser:
            return "/login"
        
        case .postResigterUser:
            return "/register"
        case .postRecovery:
            return "/recovery"
        }
    }
}
