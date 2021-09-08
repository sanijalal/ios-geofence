//
//  GeofenceViewPresenterDelegate.swift
//  GeofenceMe
//
//  Created by user205283 on 8/28/21.
//

import Foundation

protocol GeofenceViewPresenterDelegate {
    func viewNeedsUpdate()
    func promptToAssociateSSID(_ ssid: String)
}

