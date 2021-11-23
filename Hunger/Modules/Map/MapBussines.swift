//
//  MapBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 14/11/21.
//

import Foundation
import CoreLocation

final class MapBussines {
    let locationManager = CLLocationManager()
    private(set) var pinsCarrier = [RestaurantLocation]()
    private let restaurantLocationService = MapService()
    
    func fetchLocations(onFinished: @escaping (Bool) -> Void) {
        restaurantLocationService.getRestaurantsLocation(onFinished: { locationData, receivedError in
            self.pinsCarrier = locationData
            onFinished(receivedError)
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
}
