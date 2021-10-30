//
//  message.swift
//  Hunger
//
//  Created by Sebastian Mejia on 9/10/21.
//

import Foundation

struct Restaurant: Codable {
    let id: Int
    let distance: Int
    let isAvaliable: Bool
    let name: String
}

