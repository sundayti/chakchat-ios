//
//  UpdateOnlineRestrictionEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 13.02.2025.
//

import Foundation

// MARK: - UpdateOnlineRestrictionEvent
final class UpdateOnlineRestrictionEvent: Event {
    
    var newOnline: String
    
    init(newOnline: String) {
        self.newOnline = newOnline
    }
}
