//
//  ListPresenter.swift
//  Hunger
//
//  Created by Sebastian Mejia on 19/10/21.
//

import Foundation

protocol ListPresenterDelegate: AnyObject {
    func setRestaurantList()
    func showError()
    func toggleLoader(isLoading: Bool)
}

final class ListPresenter {
    
    // MARK: - Properties
    private(set) var restaurantCarrier = [RestaurantViewData]()
    private let restaurantService: RestaurantService
    private weak var restaurantViewDelegate: ListPresenterDelegate?
    var selectedRestaurantID: Int?
    
    init(service: RestaurantService) {
        self.restaurantService = service
    }
    
    // MARK: - Private methods 
    
    func fetchRestaurants() {
        restaurantViewDelegate?.toggleLoader(isLoading: true)
        
        restaurantService.getRestaurants(onFinished: { [weak self] restaurantsData, receivedError in
            
            self?.restaurantViewDelegate?.toggleLoader(isLoading: false)
            
            if receivedError {
                self?.restaurantViewDelegate?.showError()
                return
            }
            
            restaurantsData.forEach { restaurant in
                let data = RestaurantViewData(
                    id: restaurant.id,
                    distance: restaurant.distance,
                    isAvailable: restaurant.isAvailable,
                    name: restaurant.name
                )
                
                self?.restaurantCarrier.append(data)
            }
            
            self?.restaurantViewDelegate?.setRestaurantList()
        })
    }
    
    func setViewDelegate(delegate: ListPresenterDelegate) {
        self.restaurantViewDelegate = delegate
    }
}
