//
//  GeofenceViewController.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import UIKit

class GeofenceViewController: UIViewController {
    var presenter: GeofenceViewPresenter
    
    @IBOutlet weak var geofenceLabel: UILabel!
    @IBOutlet weak var insideOutsideLabel: UILabel!
    @IBOutlet weak var wifiLabel: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    
    init(presenter: GeofenceViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.presenter = GeofenceViewPresenter()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    func updateView() {
        self.geofenceLabel.text = presenter.geofenceLabelString
        self.insideOutsideLabel.text = presenter.insideOutsideLabelString
        self.wifiLabel.text = presenter.wifiLabelString
    }
    
    @IBAction func bottomButtonPressed(_ sender: Any) {
    }
    
}
