//
//  TextDisplayCell.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 06/09/2021.
//

import UIKit

class TextDisplayCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!

    func configureCell(name: String, value: String, isHighlighted: Bool) {
        nameLabel.text = name
        valueLabel.text = value
        
        if (isHighlighted == true) {
            nameLabel.textColor = .systemRed
        } else {
            nameLabel.textColor = .label
        }
    }
    
}
