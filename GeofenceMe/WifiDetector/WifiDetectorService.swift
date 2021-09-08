//
//  WifiDetectorService.swift
//  GeofenceMe
//
//  Created by Sani on 26/08/2021.
//

import Foundation
import SystemConfiguration.CaptiveNetwork

class WifiDetectorService {
    func getWiFiSsid() -> String? {
        return "SANI"
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        return ssid
    }
}
