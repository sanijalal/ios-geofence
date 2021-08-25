//
//  WelcomeViewPresenter.swift
//  GeofenceMe
//
//  Created by Sani on 24/08/2021.
//

import Foundation
import CoreLocation

class WelcomeViewPresenter {
    private var status: CLAuthorizationStatus = .authorizedAlways
    
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
    
    func buttonPressed() {
        
    }
}
