//
//  EventManager.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
final class EventManager: EventPublisherProtocol, EventRegistererProtocol {
    
    var handlerDict: [AnyHashable : [(any Event) -> Void]] = [:]
    
    func publish(event: any Event) {
        let key = ObjectIdentifier(type(of: event))
        if let handlers = handlerDict[key] {
            for handler in handlers {
                handler(event)
            }
        }
    }
    
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
