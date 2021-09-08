//
//  GeofenceDetailsCoordinatingSpy.swift
//  GeofenceMeTests
//
//  Created by Abd Sani Abd Jalal on 08/09/2021.
//

import Foundation
import UIKit
@testable import GeofenceMe

class GeofenceDetailsCoordinatingSpy: GeofenceDetailsCoordinating {
    var popDetailCalledCount: Int = 0
    
    func pushDetail(label: String, value: String?) {
            
    }
    
    func popDetail(label: String, value: String?) {
        popDetailCalledCount += 1
    }
    
    func saveButtonPressed() {
        
    }
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
    
    }
    
    
}
