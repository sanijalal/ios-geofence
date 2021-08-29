//
//  AppCoordinator.swift
//  GeofenceMe
//
//  Created by user205283 on 8/29/21.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let presenter = GeofenceViewPresenter()
        let vc = GeofenceViewController(presenter: presenter)
        presenter.coordinator = self
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.setViewControllers([vc], animated: false)
    }
    
    func presentAddGeofence() {
        let presenter = AddGeofenceViewPresenter()
        let vc = AddGeofenceViewController(presenter: presenter)
        presenter.coordinator = self
        
        self.navigationController.viewControllers.last?.present(vc, animated: true, completion: {
        })
    }
    
    func dismissAddGeofence() {
        
        if let vc = navigationController.viewControllers.last as? GeofenceViewController {
            vc.updateGeofenceInfo()
        }
        
        self.navigationController.viewControllers.last?.presentedViewController?.dismiss(animated: true, completion: {
            
        })
    }
}
