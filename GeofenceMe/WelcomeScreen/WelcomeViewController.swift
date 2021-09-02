//
//  WelcomeViewController.swift
//  GeofenceMe
//
//  Created by Sani on 23/08/2021.
//

import UIKit
import CoreLocation

class WelcomeViewController: UIViewController {
    let presenter: WelcomeViewPresenter
    var isReadyForUpdates: Bool = false
    
    required init?(coder: NSCoder) {
        presenter = WelcomeViewPresenter(locationService: LocationServiceProvider())
        super.init(coder: coder)
    }
    
    init(presenter: WelcomeViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isReadyForUpdates = true
        presenter.delegate = self
        updateCurrentView()
    }
    
    private func updateCurrentView() {
        contentLabel.text = presenter.text
        bottomButton.setTitle(presenter.buttontext, for: .normal)
    }

    @IBAction func bottomButtonPressed(_ sender: Any) {
        presenter.buttonPressed()
    }
}

extension WelcomeViewController: WelcomeViewPresenterDelegate {
    func updateView() {
        updateCurrentView()
    }
}

extension WelcomeViewController: ViewControllerAppEventResponding {
    func appDidBecomeActive() {
        if (isReadyForUpdates) {
            updateCurrentView()
        }
    }
}

