//
//  EventManager.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation

// MARK: - EventManager
final class EventManager: EventPublisherProtocol, EventRegistererProtocol {
    
    // MARK: - Properties
    var handlerDict: [AnyHashable : [(any Event) -> Void]] = [:]
    
    // MARK: - Publish
    func publish(event: any Event) {
        let key = ObjectIdentifier(type(of: event))
        if let handlers = handlerDict[key] {
            for handler in handlers {
                DispatchQueue.global(qos: .userInitiated).async {
                    handler(event)
                }
            }
        }
    }
    
    // MARK: - Register
    func register<T: Event>(eventType: T.Type, _ eventHandler: @escaping (T) -> Void) {
        let key = ObjectIdentifier(eventType)
        let handler: (any Event) -> Void = { event in
            if let typedEvent = event as? T {
                eventHandler(typedEvent)
            }
        }
        if handlerDict[key] != nil {
            handlerDict[key]?.append(handler)
        } else {
            handlerDict[key] = [handler]
        }
    }
}
