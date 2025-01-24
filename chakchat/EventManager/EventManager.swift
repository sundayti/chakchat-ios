//
//  EventManager.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
final class EventManager: EventPublisherProtocol, EventRegistererProtocol {
    
    var handlerDict: [ObjectIdentifier : [(any Event) -> Void]] = [:]
    
    func publish(event: any Event) {
        let key = ObjectIdentifier(event.self)
        if let handlers = handlerDict[key] {
            for handler in handlers {
                handler(event)
            }
        }
    }
    
    func register(eventType: any Event.Type, _ eventHandler: @escaping (any Event) -> Void) {
        let key = ObjectIdentifier(eventType)
        if handlerDict[key] != nil {
            handlerDict[key]?.append(eventHandler)
        } else {
            handlerDict[key] = [eventHandler]
        }
    }
}
