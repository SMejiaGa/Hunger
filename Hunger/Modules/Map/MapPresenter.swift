//
//  MapPresenter.swift
//  Hunger
//
//  Created by Sebastian Mejia on 14/11/21.
//

import Foundation
import CoreLocation

protocol MapPresenterDelegate: AnyObject {
    func showError()
    func setLocations()
    func toggleLoader(isEnabled: Bool)
}

final class MapPresenter {
    private let service: MapService
    private let locationManager = CLLocationManager()
    private(set) var pinsCarrier = [RestaurantLocation]()
    private weak var mapViewDelegate: MapPresenterDelegate?
    
    init(service: MapService) {
        self.service = service
    }
     
    func fetchLocations() {
        mapViewDelegate?.toggleLoader(isEnabled: true)
        
        service.getRestaurantsLocation(onFinished: { [weak self] locationData, receivedError in
            self?.mapViewDelegate?.toggleLoader(isEnabled: false)

            if receivedError {
                self?.mapViewDelegate?.showError()
                return
            }
            
            self?.pinsCarrier = locationData
            self?.mapViewDelegate?.setLocations()
        })
    }
    
    func locationPermissions() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func setViewDelegate(delegate: MapPresenterDelegate) {
        self.mapViewDelegate = delegate
    }
}
