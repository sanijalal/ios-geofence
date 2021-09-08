//
//  GeofenceDetailsCoordinator.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 07/09/2021.
//

import Foundation
import UIKit

class GeofenceDetailsCoordinator: GeofenceDetailsCoordinating {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        let presenter = GeofenceDetailsViewPresenter()
        let vc = GeofenceDetailsViewController(presenter: presenter)
        presenter.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushDetail(label: String, value: String?) {
        let detailPresenter = DetailTextInputPresenter(label: label, value: value)
        let detailVC = DetailTextInputViewController(presenter: detailPresenter)
        
        detailPresenter.coordinator = self
        
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func popDetail(label: String, value: String?) {
        navigationController.popViewController(animated: true)
        
        if let vc = navigationController.viewControllers.last as? DetailTextViewControllerResponding {
            vc.updatedTextValue(label: label, value: value)
        }
    }
    
    func saveButtonPressed() {
        navigationController.dismiss(animated: true) {
            
        }
    }
}
