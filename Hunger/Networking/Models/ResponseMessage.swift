//
//  responseMessage.swift
//  Hunger
//
//  Created by Sebastian Mejia on 9/10/21.
//

import Foundation

struct MessageResponse: Codable {
    let error: String?
    let body: [Message]
}
