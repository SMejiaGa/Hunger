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

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    
    private let presenter: MapPresenter
    
    // MARK: - Init required for xib initialization
    
    init(presenter: MapPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: Self.self), bundle: .main)
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
    
    @IBAction private func backButton() {
        navigationController?.popViewController(animated: true)
    }
}
// MARK: - MKMapView extension

private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        
        setRegion(coordinateRegion, animated: true)
    }
}

// MARK: - MapPresenterDelegate

extension MapViewController: MapPresenterDelegate {
    func toggleLoader(isEnabled: Bool) {
        isEnabled ? loader.startAnimating() : loader.stopAnimating()
    }
    
    func showError() {
        showMessage(alertMessage: Lang.Error.commonError)
    }
    
    func setLocations() {
        for resLocation in presenter.pinsCarrier {
            let pin = MKPointAnnotation()
            
            pin.coordinate = CLLocationCoordinate2D(
                latitude: CLLocationDegrees(
                    resLocation.location.latitude
                ),
                longitude: CLLocationDegrees(resLocation.location.longitude)
            )
            
            mapView.addAnnotation(pin)
        }
        
        mapView.showAnnotations(
            mapView.annotations,
            animated: true
        )
    }
}
