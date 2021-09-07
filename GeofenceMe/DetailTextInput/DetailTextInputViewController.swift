//
//  DetailTextInputViewController.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 07/09/2021.
//

import UIKit

class DetailTextInputViewController: UIViewController {

    var presenter: DetailTextInputPresenter
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = presenter.labelString
        valueTextField.text = presenter.valueString
        valueTextField.delegate = self
        
        valueTextField.becomeFirstResponder()
    }
    
    init(presenter: DetailTextInputPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func saveButtonPressed() {
        presenter.savePressed()
    }
}

extension DetailTextInputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            presenter.updateValue(text)
        }
        saveButtonPressed()
        return true
    }
}
