//
//  AddGeofenceViewPresenterDelegate.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import Foundation

protocol AddGeofenceViewPresenterDelegate: AnyObject {
    func fenceRangeChanged()
    func locationChanged()
}
