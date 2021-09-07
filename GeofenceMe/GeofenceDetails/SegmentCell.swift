//
//  SegmentCell.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 06/09/2021.
//

import UIKit

class SegmentCell: UITableViewCell {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    weak var delegate: SegmentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func controlValueChanged(_ sender: UISegmentedControl) {
        delegate?.segmentValueChanged(segment: sender.selectedSegmentIndex)
    }
    
    func configureCell(index: Int) {
        segmentControl.selectedSegmentIndex = index
    }
}
