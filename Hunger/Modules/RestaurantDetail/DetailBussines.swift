//
//  DetailBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 22/11/21.
//

import Foundation

final class DetailBussines {
    
    // MARK: - Properties
//    var restaurantToFindID: Int? = 1
    private let restaurantService = RestaurantService()
    
    // MARK: - Private methods
    
    func fetchDetails(restaurantToFindID: Int?, onFinished: @escaping (RestaurantDetail, Bool) -> Void) {
        guard let restaurantToFindID = restaurantToFindID else {
            print("Something went wrong")
            return
        }

        restaurantService.getRestaurantDetail(onFinished: { detailData, receivedError in
            onFinished(detailData, receivedError)
        }, getDetail: restaurantToFindID)
    }
}
