//
//  DetailTextInputPresenter.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 07/09/2021.
//

import Foundation

class DetailTextInputPresenter {
    
    weak var coordinator: GeofenceDetailsCoordinating?
    private let label: String
    private var value: String?
    
    init(label: String, value: String?) {
        self.label = label
        self.value = value
    }
    
    var labelString: String {
        label
    }
    
    var valueString: String {
        guard let value = value else {
            return ""
        }
        return value
    }
    
    func updateValue(_ value: String) {
        self.value = value
    }
    
    func savePressed() {
        coordinator?.popDetail(label: label, value: value)
    }
}
