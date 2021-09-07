//
//  SwitchCellDelegate.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 07/09/2021.
//

import Foundation

protocol SwitchCellDelegate: AnyObject {
    func detailChanged(detail: GeofenceDetailType, value: Bool)
}
