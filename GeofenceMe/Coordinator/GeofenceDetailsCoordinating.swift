//
//  GeofenceDetailsCoordinating.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 07/09/2021.
//

import Foundation

protocol GeofenceDetailsCoordinating: AnyObject, Coordinator {
    func pushDetail(label: String, value: String?)
    func popDetail(label: String, value: String?)
    func saveButtonPressed()
}
