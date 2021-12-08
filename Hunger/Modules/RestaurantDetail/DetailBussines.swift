//
//  DetailBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 22/11/21.
//

import Foundation

final class DetailBussines {
    
    // MARK: - Properties
    private let restaurantService: RestaurantService
    private var restaurantID: Int
    
    init(restaurantId: Int, restaurantService: RestaurantService) {
        self.restaurantID = restaurantId
        self.restaurantService = restaurantService
    }
   
    // MARK: - Private methods
    
    func fetchDetails(onFinished: @escaping (RestaurantDetail, Bool) -> Void) {
        restaurantService.getRestaurantDetail(onFinished: { detailData, receivedError in
            onFinished(detailData, receivedError)
        }, getDetail: restaurantID)
    }
}
