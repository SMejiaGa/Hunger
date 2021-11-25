//
//  RestaurantDetail.swift
//  Hunger
//
//  Created by Sebastian Mejia on 22/11/21.
//

import Foundation

struct RestaurantDetail: Codable {
    let adress: String
    let commentsCount: Int
    let id: Int
    let isFavorite: Bool
    let stars: Int
    let isOpen: Bool
    let name: String
    let rating: Rating?
}
struct Rating: Codable {
    let max: Int
    let average: Float
}
