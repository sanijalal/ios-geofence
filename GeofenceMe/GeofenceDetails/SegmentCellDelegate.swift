//
//  SegmentCellDelegate.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 06/09/2021.
//

import Foundation
import UIKit

protocol SegmentCellDelegate: AnyObject {
    func segmentValueChanged(segment: Int)
}
