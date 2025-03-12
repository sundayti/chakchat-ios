//
//  AddedMemberEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.03.2025.
//

import Foundation

class AddedMemberEvent: Event {
    let memberID: UUID
    
    init(memberID: UUID) {
        self.memberID = memberID
    }
}
