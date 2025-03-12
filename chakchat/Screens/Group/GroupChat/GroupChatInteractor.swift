//
//  GroupChatInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation
import OSLog
import Combine

final class GroupChatInteractor: GroupChatBusinessLogic {
    private let presenter: GroupChatPresentationLogic
    private let worker: GroupChatWorkerLogic
    private let eventSubscriber: EventSubscriberProtocol
    private let errorHandler: ErrorHandlerLogic
    private let chatData: ChatsModels.GroupChat.Response
    private let logger: OSLog
    
    private var cancellables = Set<AnyCancellable>()
    
    var onRouteBack: (() -> Void)?
    
    init(
        presenter: GroupChatPresentationLogic,
        worker: GroupChatWorkerLogic,
        eventSubscriber: EventSubscriberProtocol,
        errorHandler: ErrorHandlerLogic,
        chatData: ChatsModels.GroupChat.Response,
        logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.eventSubscriber = eventSubscriber
        self.errorHandler = errorHandler
        self.chatData = chatData
        self.logger = logger
        
        subscribeToEvents()
    }
    
    func sendTextMessage(_ message: String) {
        worker.sendTextMessage(message)
    }
    
    func passChatData() {
        presenter.passChatData(chatData)
    }
        
    func handleAddedMemberEvent(_ event: AddedMemberEvent) {
        print("Handle new member")
    }
    
    func handleDeletedMemberEvent(_ event: DeletedMemberEvent) {
        print("Handle member deletion")
    }
    
    func routeBack() {
        onRouteBack?()
    }
    
    private func subscribeToEvents() {
        eventSubscriber.subscribe(AddedMemberEvent.self) { [weak self] event in
            self?.handleAddedMemberEvent(event)
        }.store(in: &cancellables)
        eventSubscriber.subscribe(DeletedMemberEvent.self) { [weak self] event in
            self?.handleDeletedMemberEvent(event)
        }.store(in: &cancellables)
    }
}
