//
//  UpdatedGroupInfoEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.03.2025.
//

import Foundation

final class UpdatedGroupInfoEvent: Event {
    let name: String
    let description: String?
    
    init(name: String, description: String?) {
        self.name = name
        self.description = description
    }
}
