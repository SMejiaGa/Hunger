//
//  DetailBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 22/11/21.
//

import Foundation

final class DetailBussines {
    
    // MARK: - Properties
    var findRestaurant = 0
    private let restaurantService = RestaurantService()
    
    // MARK: - Private methods
    
    func fetchDetails(onFinished: @escaping (RestaurantDetail, Bool) -> Void) {
        restaurantService.getRestaurantDetail(onFinished: { detailData, receivedError in
            onFinished(detailData, receivedError)
        }, getDetail: findRestaurant)
    }
}
