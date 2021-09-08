//
//  DefaultNameGenerator.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 08/09/2021.
//

import Foundation

class DefaultNameGenerator {
    class func create() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let now = Date()
        let dateString = formatter.string(from:now)
        return dateString
    }
}
