//
//  MapBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 14/11/21.
//

import Foundation

final class MapBussines{
     var pinsCarrier = [MapPointer]()
    private let restaurantLocationService = MapService()
    
    func fetchLocations(onFinished: @escaping (Bool) ->Void){
        restaurantLocationService.getRestaurantsLocation(onFinished: { locationData, receivedError in
            self.pinsCarrier = locationData
            onFinished(receivedError)
        })
    }
}
