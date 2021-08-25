//
//  GeofenceStorageService.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import Foundation

class GeofenceStorageService: GeofenceStorageProviding {
    private var userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func saveGeofence(_ info: GeofenceInfo) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(info)
            userDefaults.set(data, forKey: "geofence")
        } catch {
            
        }
    }
    
    func getGeofence() -> GeofenceInfo? {
        guard let data = userDefaults.object(forKey: "geofence") as? Data else {
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
}
