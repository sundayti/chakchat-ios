//
//  EventRegistererProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
protocol EventRegistererProtocol {
    func register<T: Event>(eventType: T.Type, _ eventHandler: @escaping (T) -> Void)
}
