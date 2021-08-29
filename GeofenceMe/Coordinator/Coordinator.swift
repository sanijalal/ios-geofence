//
//  Coordinator.swift
//  GeofenceMe
//
//  Created by user205283 on 8/29/21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
