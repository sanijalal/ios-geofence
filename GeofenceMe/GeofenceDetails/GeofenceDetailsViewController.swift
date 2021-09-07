//
//  GeofenceDetailsViewController.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 06/09/2021.
//

import UIKit
import CoreLocation
import MapKit

class GeofenceDetailsViewController: UIViewController {
    var presenter: GeofenceDetailsViewPresenter
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapViewHeightConstraint: NSLayoutConstraint!
    init(presenter: GeofenceDetailsViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        
        tableView.register(UINib(nibName: "TextDisplayCell", bundle: nil),
                           forCellReuseIdentifier: "TextDisplayCell")
        tableView.register(UINib(nibName: "SwitchCell", bundle: nil),
                           forCellReuseIdentifier: "SwitchCell")
        tableView.register(UINib(nibName: "SegmentCell", bundle: nil),
                           forCellReuseIdentifier: "SegmentCell")
        tableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 50, right: 0)
        mapView.delegate = self

        let coordinate = CLLocationCoordinate2D(latitude: presenter.coordinate.latitude, longitude: presenter.coordinate.longitude)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: presenter.mapRange, longitudinalMeters: presenter.mapRange)
        mapView.setRegion(region, animated: false)
        presenter.delegate = self
        presenter.updateSegmentIndex(index: presenter.radiusSegmentIndex)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.startLocationUpdate()
    }
    
    private func changeFenceRange(latitude: Double, longitude: Double, fenceRadius: CLLocationDistance) {
        let overlays = mapView.overlays
        mapView.removeOverlays(overlays)

        let circle = MKCircle(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: fenceRadius)
        mapView.addOverlay(circle)
    }
    
    private func annotateAtLocation(latitude: Double, longitude: Double, radius: CLLocationDistance) {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        let annotation = MapPin(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        mapView.addAnnotation(annotation)
        changeFenceRange(latitude: latitude, longitude: longitude, fenceRadius: radius)
    }
}

extension GeofenceDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let detailType = presenter.details[indexPath.row]
        if (detailType == .Radius) {
            return 80
        }
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = presenter.details[indexPath.row]
        if detail == .Name {
            presenter.nameFieldSelected()
        }
    }
}

extension GeofenceDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detail = presenter.details[indexPath.row]
        switch detail {
        case .Name, .Location:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextDisplayCell", for: indexPath) as! TextDisplayCell
            if detail == .Name {
                cell.configureCell(name: "Name", value: presenter.name)
            } else if detail == .Location {
                cell.configureCell(name: "Location", value: "Current Location")
            }
            return cell
        case .OnEntry, .OnExit:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
            if detail == .OnEntry {
                cell.configureCell(label: "On Entry", value: presenter.notifyOnEntry, type: detail)
            } else if detail == .OnExit {
                cell.configureCell(label: "On Exit", value: presenter.notifyOnExit, type: detail)
            }
            return cell
        case .Radius:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SegmentCell", for: indexPath) as! SegmentCell
            cell.delegate = self
            return cell
        }
    }
}

extension GeofenceDetailsViewController: SegmentCellDelegate {
    func segmentValueChanged(segment: Int) {
        presenter.updateSegmentIndex(index: segment)
    }
}

extension GeofenceDetailsViewController: SwitchCellDelegate {
    func detailChanged(detail: GeofenceDetailType, value: Bool) {
        if detail == .OnEntry {
            presenter.updateOnEntryMonitoring(value: value)
        } else if detail == .OnExit {
            presenter.updateOnExitMonitoring(value: value)
        }
    }
}

extension GeofenceDetailsViewController: GeofenceDetailsPresenterDelegate {
    func locationUpdated(location: CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: presenter.mapRange, longitudinalMeters: presenter.mapRange)
        mapView.setRegion(region, animated: true)
        annotateAtLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude , radius: CLLocationDistance(presenter.radius))
    }
    
    func updateZoomAtLocation(location: CLLocationCoordinate2D, zoom: Double) {
        let region = MKCoordinateRegion(center: location, latitudinalMeters: zoom, longitudinalMeters: zoom)
        mapView.setRegion(region, animated: true)
    }
    
    func updateFenceRegion(location: CLLocationCoordinate2D, radius: Double) {
        changeFenceRange(latitude: location.latitude, longitude: location.longitude, fenceRadius: radius)
    }
}

extension GeofenceDetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = UIColor.init(red: 0, green: 1, blue: 0, alpha: 0.25)
        return circleRenderer
    }
}

extension GeofenceDetailsViewController: DetailTextViewControllerResponding {
    func updatedTextValue(label: String, value: String?) {
        presenter.changeName(value)
        tableView.reloadData()
    }
}

