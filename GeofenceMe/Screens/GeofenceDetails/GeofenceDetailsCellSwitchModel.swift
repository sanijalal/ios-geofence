//
//  GeofenceDetailsCellSwitchModel.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 06/09/2021.
//

import Foundation

struct GeofenceDetailsCellSwitchModel: GeofenceDetailsCellModel {
    var name: String
    let type: GeofenceDetailsCellType = .BoolSwitch
    var value: Bool = false
}
