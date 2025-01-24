//
//  NicknameEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
final class NicknameEvent: Event {
    var newNickname: String
    
    init(newNickname: String) {
        self.newNickname = newNickname
    }
}
