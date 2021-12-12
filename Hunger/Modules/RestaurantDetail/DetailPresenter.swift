//
//  DetailBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 22/11/21.
//

import Foundation

protocol DetailPresenterDelegate: AnyObject {
    func setDetails(detailData: RestaurantDetail)
    func restaurantError()
    func toggleloader(isEnabled: Bool)
}

final class DetailPresenter {
    
    // MARK: - Properties
    private weak var detailViewDelegate: DetailPresenterDelegate?
    private let restaurantService: RestaurantService
    private var restaurantID: Int
    
    init(restaurantId: Int, service: RestaurantService) {
        self.restaurantID = restaurantId
        self.restaurantService = service
    }
   
    // MARK: - Private methods
    
    func fetchDetails() {
        
        guard let detailViewDelegate = self.detailViewDelegate else {
            return
        }
        
        detailViewDelegate.toggleloader(isEnabled: true)
        
        restaurantService.getRestaurantDetail(onFinished: { detailData, receivedError in

            if !receivedError {
                detailViewDelegate.toggleloader(isEnabled: false)
                detailViewDelegate.setDetails(detailData: detailData)
            } else {
                detailViewDelegate.restaurantError()
            }
            
        }, getDetail: restaurantID)
    }
    
    func setViewDelegate(delegate: DetailPresenterDelegate) {
        self.detailViewDelegate = delegate
    }
}
