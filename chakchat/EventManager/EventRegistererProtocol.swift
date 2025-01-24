//
//  EventRegistererProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
protocol EventRegistererProtocol {
    func register(eventType: any Event.Type, _ eventHandler: @escaping (_ event: any Event) -> Void)
}
