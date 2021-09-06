//
//  GeofenceStorageService.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import Foundation

class GeofenceStorageService: GeofenceStorageProviding {
    private var userDefaults: UserDefaults
    private let plistKey = "geofence"
    
    public init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func saveGeofence(_ info: GeofenceInfo) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(info)
            userDefaults.set(data, forKey: plistKey)
        } catch {
            
        }
    }
    
    func getGeofence() -> GeofenceInfo? {
        guard let data = userDefaults.object(forKey: plistKey) as? Data else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let info = try decoder.decode(GeofenceInfo.self, from: data)
            return info
        } catch {
            return nil
        }        
    }
    
    func deleteGeofence() {
        userDefaults.removeObject(forKey: plistKey)
    }
}
