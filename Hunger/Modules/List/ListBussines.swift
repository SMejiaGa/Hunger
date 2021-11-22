//
//  ListBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 19/10/21.
//

import Foundation

final class ListBussines {
    
    // MARK: - Properties
    private(set) var restaurantCarrier = [Restaurant]()
    private let restaurantService = RestaurantService()
    
    // MARK: - Private methods
    
    func fetchRestaurants(onFinished: @escaping (Bool) -> Void) {
        restaurantService.getRestaurants(onFinished: { restaurantsData, receivedError in
            self.restaurantCarrier = restaurantsData
            onFinished(receivedError)
        })
    }
}
