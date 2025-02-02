//
//  EventRegistererProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import Combine

// MARK: - EventSubscriberProtocol
protocol EventSubscriberProtocol {
    
    func subscribe<T: Event>(_ eventType: T.Type, eventHandler: @escaping (T) -> Void) -> AnyCancellable
}
