//
//  GeofenceDetailsCellModel.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 06/09/2021.
//

import Foundation

protocol GeofenceDetailsCellModel {
    var name: String { get set }
    var type: GeofenceDetailsCellType { get }
}
