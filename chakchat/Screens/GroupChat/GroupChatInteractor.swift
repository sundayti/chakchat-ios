//
//  GroupChatInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation
import OSLog

final class GroupChatInteractor: GroupChatBusinessLogic {
    private let presenter: GroupChatPresentationLogic
    private let worker: GroupChatWorkerLogic
    private let eventSubscriber: EventSubscriberProtocol
    private let errorHandler: ErrorHandlerLogic
    private let chatData: ChatsModels.GroupChat.Response
    private let logger: OSLog
    
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
    }
    
    func sendTextMessage(_ message: String) {
        worker.sendTextMessage(message)
    }
    
    func passChatData() {
        presenter.passChatData(chatData)
    }
    
    func routeBack() {
        onRouteBack?()
    }
}
