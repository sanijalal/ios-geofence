//
//  WelcomeViewPresenter.swift
//  GeofenceMe
//
//  Created by Sani on 24/08/2021.
//

import Foundation
import CoreLocation
import UIKit

class WelcomeViewPresenter {
    weak var coordinator: AppCoordinating?
    
    var locationService: LocationServiceProviding
    weak var delegate: WelcomeViewPresenterDelegate?
    
    init(locationService: LocationServiceProviding) {
        self.locationService = locationService
        self.locationService.delegate = self
    }
    
    private var status: CLAuthorizationStatus {
        locationService.getCurrentAuthorisationState()
    }
    
    var text: String {
        var contentText = ""
        switch status {
        case .notDetermined:
            contentText = "Not determined."
        case .restricted:
            contentText = "Restricted"
        case .denied:
            contentText = "Denied"
        case .authorizedAlways:
            contentText = "Authorised Always"
        case .authorizedWhenInUse:
            contentText = "Authorised When In Use"
        @unknown default:
            contentText = "We could not determine the status."
        }
        return contentText
    }
    
    var buttontext: String {
        var contentText = ""
        switch status {
        case .notDetermined:
            contentText = "Grant Permission"
        case .restricted:
            contentText = ""
        case .denied:
            contentText = "Open Settings"
        case .authorizedAlways, .authorizedWhenInUse:
            contentText = "Good to go!"
        @unknown default:
            contentText = "Contact developers."
        }
        return contentText
    }
    
    func presentGeofencePage() {
        coordinator?.pushGeofenceView()
    }
    
    func openSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
           UIApplication.shared.open(settingsUrl)
         }
    }
    
    func buttonPressed() {
        switch status {
        case .notDetermined:
            locationService.requestLocationPermission()
        case .restricted:
            print("Cannot do anything")
        case .denied:
            openSettings()
        case .authorizedAlways, .authorizedWhenInUse:
            presentGeofencePage()
        @unknown default:
            print("Ok this is weird")
        }
    }
}

extension WelcomeViewPresenter: LocationServiceDelegate {
    func authorisationStatusUpdatedWith(_ status: CLAuthorizationStatus) {
        delegate?.updateView()
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            presentGeofencePage()
        }
    }
    
    func locationRetrieved(location: CLLocation) {
        
    }
}
