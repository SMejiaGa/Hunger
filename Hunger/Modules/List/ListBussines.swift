//
//  ListBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 19/10/21.
//

import Foundation

class ListBussines {
    
    // MARK: -Properties
    private(set) var restaurantCarrier = [Restaurant]()
    private let webService = WebService()
    
    // MARK: -Private methods
    
    func fetchRestaurants(onFinished: @escaping (Bool) ->Void){
        webService.getRestaurants(onFinished: { restaurantsData, receivedError in
            self.restaurantCarrier = restaurantsData
            onFinished(receivedError)
        })
    }
}
