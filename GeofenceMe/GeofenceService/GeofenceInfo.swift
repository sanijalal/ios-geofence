//
//  GeofenceInfo.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import Foundation

struct GeofenceInfo: Codable {
    let latitude: Double
    let longitude: Double
    
    let radius: Int
    
    var monitorOnExit: Bool
    var monitorOnEntry: Bool
    
    var geofenceName: String
    var ssid: String? = nil
}
