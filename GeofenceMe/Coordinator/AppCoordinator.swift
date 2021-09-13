//
//  AppCoordinator.swift
//  GeofenceMe
//
//  Created by user205283 on 8/29/21.
//

import Foundation
import UIKit
import CoreLocation

class AppCoordinator: AppCoordinating {
    var locationService: LocationServiceProviding
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    var presentedCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, locationService: LocationServiceProviding = LocationServiceProvider()) {
        self.navigationController = navigationController
        self.locationService = locationService
    }
    
    func start() {

        var viewControllers = [UIViewController]()
        
        if (locationService.getCurrentAuthorisationState() == .authorizedAlways) {
            let presenter = GeofenceViewPresenter()
            let vc = GeofenceViewController(presenter: presenter)
            presenter.coordinator = self
            viewControllers.append(vc)
        } else {
            let presenter = WelcomeViewPresenter(locationService: locationService)
            let vc = WelcomeViewController(presenter: presenter)
            presenter.coordinator = self
            viewControllers.append(vc)
        }

        self.navigationController.isNavigationBarHidden = true
        self.navigationController.setViewControllers(viewControllers, animated: false)
    }
    
    func pushGeofenceView() {
        let presenter = GeofenceViewPresenter()
        let vc = GeofenceViewController(presenter: presenter)
        presenter.coordinator = self
        
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.setViewControllers([vc], animated: true)
    }
    
    func presentAddGeofence() {
        
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .fullScreen
        
        let coordinator = GeofenceDetailsCoordinator(navigationController: navigationController)
        coordinator.start()
        presentedCoordinator = coordinator
        
        self.navigationController.viewControllers.last?.present(navigationController, animated: true, completion: {
        })
    }
    
    func dismissAddGeofence() {
        if let vc = navigationController.viewControllers.last as? GeofenceViewController {
            vc.updateGeofenceInfo()
        }
        
        self.navigationController.viewControllers.last?.presentedViewController?.dismiss(animated: true, completion: {
            
        })
    }
    
    func appDidBecomeActive() {
        if let topVC = navigationController.topViewController as? ViewControllerAppEventResponding {
            topVC.appDidBecomeActive()
        }
    }    
}

extension AppCoordinator: GeofenceDetailsParentCoordinating {
    func geofenceDetailsDidSave() {
        if let topVC = navigationController.topViewController as? GeofenceDetailsResponding {
            topVC.geofenceDetailsDismissed()
        }
    }
}
