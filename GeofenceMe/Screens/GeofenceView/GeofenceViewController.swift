//
//  GeofenceViewController.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import UIKit
import MapKit

class GeofenceViewController: UIViewController {
    var presenter: GeofenceViewPresenter
    
    @IBOutlet weak var geofenceLabel: UILabel!
    @IBOutlet weak var insideOutsideLabel: UILabel!
    @IBOutlet weak var wifiLabel: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var geofenceIndicatorView: UIView!
    
    @IBOutlet weak var geofenceInsideOutIndicatorView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var readyForAppEventUpdates = false
    
    init(presenter: GeofenceViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.presenter = GeofenceViewPresenter()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        self.presenter.delegate = self
        presenter.getData()
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.retrieveGeofenceInfo()
        updateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.checkSSIDAssociation()
        readyForAppEventUpdates = true
    }
    
    func updateView() {
        self.geofenceLabel.text = presenter.geofenceLabelString
        self.insideOutsideLabel.text = presenter.insideOutsideLabelString
        self.wifiLabel.text = presenter.wifiLabelString
        updateMapView(geofenceInfo: presenter.geofenceInfo, latitude: presenter.latitude, longitude: presenter.longitude)
        
        self.geofenceIndicatorView.backgroundColor = UIColor.init(named: presenter.geofenceColorName)
        self.geofenceInsideOutIndicatorView.backgroundColor = UIColor.init(named: presenter.insideOutsideColorName)
        
        bottomButton.setTitle(presenter.bottomButtonString, for: .normal)
    }
    
    private func updateMapView(geofenceInfo: GeofenceInfo?, latitude: Double, longitude: Double) {
        let overlays = mapView.overlays
        mapView.removeOverlays(overlays)
        
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        if let geofenceInfo = geofenceInfo {
            let circle = MKCircle(center: CLLocationCoordinate2D(latitude: geofenceInfo.latitude, longitude: geofenceInfo.longitude), radius: CLLocationDistance(geofenceInfo.radius))
            mapView.addOverlay(circle)
        }
        
        let annotation = MapPin(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                        latitudinalMeters: 2000,
                                        longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
    }
    
    func updateGeofenceInfo() {
        presenter.retrieveGeofenceInfo()
        viewNeedsUpdate()
    }
    
    @IBAction func bottomButtonPressed(_ sender: Any) {
        presenter.bottomButtonPressed()
    }
    
}

extension GeofenceViewController: GeofenceViewPresenterDelegate {
    func promptToAssociateSSID(_ ssid: String) {
        let alert = UIAlertController(title: "Associate with this Wi-fi: \(ssid)?", message: "You can associate this Wi-fi with this location so we can use the wi-fi to determine if you are in the geofence.", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { action in
            self.presenter.updateCurrentGeofenceWithCurrentSSID()
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { action in
            
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        alert.preferredAction = yesAction
        self.present(alert, animated: true) {
            
        }
    }
    
    func viewNeedsUpdate() {
        updateView()
    }
}

extension GeofenceViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = UIColor.init(red: 0, green: 1, blue: 0, alpha: 0.25)
        return circleRenderer
    }
}

extension GeofenceViewController: GeofenceDetailsResponding {
    func geofenceDetailsDismissed() {
        presenter.getData()
        updateView()
    }
}

extension GeofenceViewController: ViewControllerAppEventResponding {
    func appDidBecomeActive() {
        if (readyForAppEventUpdates == false) { return }
        presenter.checkSSIDAssociation()
    }
}
