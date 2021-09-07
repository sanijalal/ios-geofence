//
//  CoordinatorSpy.swift
//  GeofenceMeTests
//
//  Created by Abd Sani Abd Jalal on 01/09/2021.
//

import Foundation
import UIKit
@testable import GeofenceMe

class AppCoordinatingSpy: AppCoordinating {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        
    }
    
    var pushGeofenceViewCount = 0
    
    func pushGeofenceView() {
        pushGeofenceViewCount += 1
    }
    
    var pushDetailCalledCount = 0
    var popDetailCalledCount = 0
    
    func pushDetail(label: String, value: String?) {
        pushDetailCalledCount += 1
    }
    
    func popDetail(label: String, value: String?) {
        popDetailCalledCount += 1
    }
    
}
