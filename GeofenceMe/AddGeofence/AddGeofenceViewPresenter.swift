//
//  AddGeofenceViewPresenter.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import Foundation
import MapKit

class AddGeofenceViewPresenter {
    var latitude: Double
    var longitude: Double
    var currentFenceRange: CLLocationDistance = 50
    var currentMapRange: CLLocationDistance = 300
    
    weak var delegate: AddGeofenceViewPresenterDelegate?
    
    init (latitude: Double, longitude: Double) {
        self.latitude = 21.282778
        self.longitude = -157.829444
    }
    
    func segmentSelected(index: Int) {
        currentFenceRange = CLLocationDistance((index + 1) * 50)
        currentMapRange = currentFenceRange + 250
        
        delegate?.fenceRangeChanged()
    }
    
    func didRetrieveLocation() {
        delegate?.locationChanged()
    }
    
}
