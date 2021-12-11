//
//  MapPresenter.swift
//  Hunger
//
//  Created by Sebastian Mejia on 14/11/21.
//

import Foundation
import CoreLocation

protocol MapPresenterDelegate: AnyObject {
    func setLocations()
    func showError()
}

final class MapPresenter {
    private weak var mapViewDelegate: MapPresenterDelegate?
    private let locationManager = CLLocationManager()
    private(set) var pinsCarrier = [RestaurantLocation]()
    private let service: MapService
    
    init(service: MapService) {
        self.service = service
    }
     
    func fetchLocations() {
        service
            .getRestaurantsLocation(onFinished: {[weak self] locationData, receivedError in
                
                if receivedError {
                    self?.mapViewDelegate?.showError()
                    return
                }
                self?.pinsCarrier = locationData
                self?.mapViewDelegate?.setLocations()
            })
    }
    
    func locationPermissions() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func setViewDelegate(delegate: MapPresenterDelegate) {
        self.mapViewDelegate = delegate
    }
}
