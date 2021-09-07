//
//  GeofenceDetailsCellSegment.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 06/09/2021.
//

import Foundation

struct GeofenceDetailsCellSegment: GeofenceDetailsCellModel {
    var name: String
    let type: GeofenceDetailsCellType = .SegmentControl
    let options = [("50", 50), ("100",100), ("200", 200)]
    var selectedIndex = 0
}
