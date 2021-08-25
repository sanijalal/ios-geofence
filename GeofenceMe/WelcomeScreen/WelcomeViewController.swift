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
    
    required init?(coder: NSCoder) {
        presenter = WelcomeViewPresenter()
        super.init(coder: coder)
    }
    
    init(locationServiceProvider: LocationServiceProviding, presenter: WelcomeViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCurrentView()
    }
    
    private func updateCurrentView() {
        contentLabel.text = presenter.text
    }

    @IBAction func bottomButtonPressed(_ sender: Any) {
        presenter.buttonPressed()
    }
}

