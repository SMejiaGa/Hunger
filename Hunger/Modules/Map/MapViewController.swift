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

    private let presenter: MapPresenter

    @IBOutlet private weak var mapView: MKMapView!
    @IBAction private func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Init required for xib initialization
    
    init(presenter: MapPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: MapViewController.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        presenter.locationPermissions()
        mapView.userTrackingMode = .follow
        presenter.fetchLocations()
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

extension MapViewController: MapPresenterDelegate {
    
    func showError() {
        showMessage(alertMessage: Lang.Error.commonError)
    }
    
    func setLocations() {
        for resLocation in self.presenter.pinsCarrier {
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
