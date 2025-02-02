//
//  EventManager.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import Combine

// MARK: - EventManager
final class EventManager: EventPublisherProtocol, EventSubscriberProtocol {
        
    private var cancellables = Set<AnyCancellable>()
    private var subjects: [ObjectIdentifier: Any] = [:]
    
    func publish<T>(event: T) where T : Event {
        let key = ObjectIdentifier(T.self)
        if let subject = subjects[key] as? PassthroughSubject<T, Never> {
            subject.send(event)
        }
    }
    
    func subscribe<T>(_ eventType: T.Type, eventHandler: @escaping (T) -> Void) -> AnyCancellable where T : Event {
        let key = ObjectIdentifier(eventType)
        if subjects[key] == nil {
            subjects[key] = PassthroughSubject<T, Never>()
        }
        guard let subject = subjects[key] as? PassthroughSubject<T, Never> else {
            fatalError("Failed to cast subject")
        }
        return subject.sink(receiveValue: eventHandler)
    }
}
