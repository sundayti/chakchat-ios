//
//  EventManager.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import Combine
import OSLog

// MARK: - OSLogOutputStream
struct OSLogOutputStream: TextOutputStream {
    let log: OSLog
    let level: OSLogType

    func write(_ string: String) {
        if !string.isEmpty && string != "\n" {
            os_log("%{public}@", log: log, type: level, string)
        }
    }
}

// MARK: - EventManager
final class EventManager: EventPublisherProtocol, EventSubscriberProtocol {
        
    private var cancellables = Set<AnyCancellable>()
    private var subjects: [ObjectIdentifier: Any] = [:]
    private let logger: OSLog = OSLog(subsystem: "com.chakchat.combinelogger", category: "DataStreamLog")
    private lazy var logStream: OSLogOutputStream = OSLogOutputStream(log: logger, level: .debug)
    
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
        
        return subject
            .print("Datastream", to: logStream)
            .sink(receiveValue: eventHandler)
    }
}
