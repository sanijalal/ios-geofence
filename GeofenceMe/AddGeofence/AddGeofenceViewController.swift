//
//  AddGeofenceViewController.swift
//  GeofenceMe
//
//  Created by Sani on 24/08/2021.
//

import UIKit
import MapKit
import CoreLocation

class AddGeofenceViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var presenter: AddGeofenceViewPresenter
    
    required init?(coder: NSCoder) {
        presenter = AddGeofenceViewPresenter()
        super.init(coder: coder)
    }
    
    init(presenter: AddGeofenceViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        presenter.delegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.delegate = self
        
        mapView.delegate = self
        mapView.isZoomEnabled = false
        mapView.isPitchEnabled = false
        mapView.isScrollEnabled = false
        mapView.isRotateEnabled = false
        
        // Do any additional setup after loading the view.
        showCurrentLocation(latitude: presenter.latitude, longitude: presenter.longitude, distance: presenter.currentMapRange)
        annotateAtLocation(latitude: presenter.latitude, longitude: presenter.longitude, radius: presenter.currentFenceRange)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.startLocationUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.stopLocationUpdate()
    }
    
    @IBAction func controlChanged(_ sender: UISegmentedControl) {
        presenter.segmentSelected(index: sender.selectedSegmentIndex)
    }
    
    private func changeFenceRange(latitude: Double, longitude: Double, fenceRadius: CLLocationDistance, mapDistance: CLLocationDistance) {
        let overlays = mapView.overlays
        mapView.removeOverlays(overlays)

        let circle = MKCircle(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: fenceRadius)
        mapView.addOverlay(circle)
        
        showCurrentLocation(latitude: latitude, longitude: longitude, distance: mapDistance)
    }
    
    func showCurrentLocation(latitude: Double, longitude: Double, distance: CLLocationDistance) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                        latitudinalMeters: distance,
                                        longitudinalMeters: distance)
        mapView.setRegion(region, animated: true)
    }
    
    func annotateAtLocation(latitude: Double, longitude: Double, radius: CLLocationDistance) {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        let overlays = mapView.overlays
        mapView.removeOverlays(overlays)
        
        let annotation = MapPin(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        mapView.addAnnotation(annotation)

        let circle = MKCircle(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: radius)
        mapView.addOverlay(circle)
    }
    
    @IBAction func bottomButtonPressed(_ sender: Any) {
        presenter.saveGeofence()
        
        if let presentedVC = self.presentingViewController as? GeofenceViewController {
            presentedVC.hackUpdateGeofence()
        }
        
        self.dismiss(animated: true) {
            
        }
    }
    
}

extension AddGeofenceViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = UIColor.init(red: 0, green: 1, blue: 0, alpha: 0.25)
        return circleRenderer
    }
}

extension AddGeofenceViewController: AddGeofenceViewPresenterDelegate {
    func locationChanged() {
        showCurrentLocation(latitude: presenter.latitude, longitude: presenter.longitude, distance: presenter.currentMapRange)
        annotateAtLocation(latitude: presenter.latitude, longitude: presenter.longitude, radius: presenter.currentFenceRange)
    }
    
    func fenceRangeChanged() {
        changeFenceRange(latitude: presenter.latitude, longitude: presenter.longitude, fenceRadius: presenter.currentFenceRange, mapDistance: presenter.currentMapRange)
    }
}

