//
//  WifiDetectorService.swift
//  GeofenceMe
//
//  Created by Sani on 26/08/2021.
//

import Foundation
import SystemConfiguration.CaptiveNetwork
import NetworkExtension

class WifiDetectorService {
    func getSSIDName(callback: @escaping ( (String?) -> Void )) {
//        NEHotspotNetwork.fetchCurrent { network in
//            callback(network?.ssid)
//        }
        callback(nil)
        // This needs to be tested on actual device with entitlement.
    }
}
