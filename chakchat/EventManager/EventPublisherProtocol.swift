//
//  EventManagerProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
protocol EventPublisherProtocol {
    func publish(event: any Event)
}
