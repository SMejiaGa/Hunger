//
//  MapPointer.swift
//  Hunger
//
//  Created by Sebastian Mejia on 14/11/21.
//

import Foundation

struct Location: Codable{
    let latitude: Float
    let longitude: Float
}

struct MapPointer: Codable{
    let name: String
    let location: Location
}
