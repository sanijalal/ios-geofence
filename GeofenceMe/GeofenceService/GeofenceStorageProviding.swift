//
//  GeofenceStorageProviding.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import Foundation

protocol GeofenceStorageProviding {
    func saveGeofence(_ info: GeofenceInfo)
    func getGeofence() -> GeofenceInfo?
    func deleteGeofence()
}
