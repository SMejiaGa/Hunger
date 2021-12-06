//
//  MapViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 14/11/21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    private let bussines = MapBussines()

    @IBOutlet private weak var mapView: MKMapView!
    @IBAction private func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bussines.locationPermissions()
        mapView.userTrackingMode = .follow
        fetchPins()
    }
    
    private func fetchPins() {
        bussines.fetchLocations { [weak self] errorExist in
            guard let self = self else { return }
            if errorExist {
                
                self.showMessage(
                    alertMessage: Lang.Error.commonError
                )
            } else {
                self.addPointersToMap()
            }
        }
    }
    
    private func addPointersToMap() {
        for resLocation in self.bussines.pinsCarrier {
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2D(
                latitude: CLLocationDegrees(
                    resLocation.location.latitude
                ),
                longitude: CLLocationDegrees(resLocation.location.longitude)
            )
            mapView.addAnnotation(pin)
        }
        
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
