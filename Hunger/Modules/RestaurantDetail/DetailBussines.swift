//
//  DetailBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 22/11/21.
//

import Foundation

final class DetailBussines {
    
    // MARK: - Properties
    private let restaurantService = RestaurantService()
    private var restaurantID: Int?
   
    // MARK: - Private methods
    
    func fetchDetails(onFinished: @escaping (RestaurantDetail, Bool) -> Void) {
        
        guard let restaurantFound = restaurantID else {
            print(Lang.Error.commonError)
            return
        }
        restaurantService.getRestaurantDetail(onFinished: { detailData, receivedError in
            onFinished(detailData, receivedError)
        }, getDetail: restaurantFound)
    }
    
    func updateRestaurantId(id: Int?) {
        restaurantID = id
    }
}
