//
//  SwitchCell.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 06/09/2021.
//

import UIKit

class SwitchCell: UITableViewCell {

    @IBOutlet weak var cellSwitch: UISwitch!
    @IBOutlet weak var nameLabel: UILabel!
    weak var delegate: SwitchCellDelegate?
    
    private var detailType: GeofenceDetailType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(label: String, value: Bool, type: GeofenceDetailType, isHighlighted: Bool) {
        nameLabel.text = label
        cellSwitch.setOn(value, animated: false)
        detailType = type
        
        updateLabelColor(isHighlighted: isHighlighted)
    }
    
    func updateLabelColor(isHighlighted: Bool) {
        if (isHighlighted == true) {
            nameLabel.textColor = .systemRed
        } else {
            nameLabel.textColor = .label
        }
    }

    @IBAction func valueChanged(_ sender: UISwitch) {
        nameLabel.textColor = .label
        if let detailType = detailType {
            delegate?.detailChanged(detail: detailType, value: sender.isOn)
        }
    }
}
