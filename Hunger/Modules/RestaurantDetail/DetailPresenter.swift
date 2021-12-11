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
        restaurantService.getRestaurantDetail(onFinished: { [weak self] detailData, receivedError in
            if !receivedError {
                self?.detailViewDelegate?.setDetails(detailData: detailData)
            } else {
                self?.detailViewDelegate?.restaurantError()
            }
            
        }, getDetail: restaurantID)
    }
    
    func setViewDelegate(delegate: DetailPresenterDelegate) {
        self.detailViewDelegate = delegate
    }
}
