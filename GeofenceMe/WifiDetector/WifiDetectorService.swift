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
        NEHotspotNetwork.fetchCurrent { network in
            print("Hotspot Network fetched!")
            print(network?.bssid)
            print(network?.isSecure)
            callback(nil)
        }
    }
}
