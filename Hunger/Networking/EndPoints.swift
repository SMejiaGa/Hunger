//
//  EndPoints.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import Foundation

enum Endpoints {
    case getMessages
    case postMessage
    
    var url: String {
        switch self {
        case .getMessages:
            return "/message"
            
        case .postMessage:
            return "/message"
        }
    }
}
