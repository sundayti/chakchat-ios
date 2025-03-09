//
//  GroupProfileEditInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation
import OSLog

final class GroupProfileEditInteractor: GroupProfileEditBusinessLogic {
    private let presenter: GroupProfileEditPresentationLogic
    private let worker: GroupProfileEditWorkerLogic
    private let errorHandler: ErrorHandlerLogic
    private let eventPublisher: EventPublisherProtocol
    private let chatData: GroupProfileEditModels.ProfileData
    private let logger: OSLog
    
    init(
        presenter: GroupProfileEditPresentationLogic,
        worker: GroupProfileEditWorkerLogic,
        errorHandler: ErrorHandlerLogic,
        eventPublisher: EventPublisherProtocol,
        chatData: GroupProfileEditModels.ProfileData,
        logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.errorHandler = errorHandler
        self.eventPublisher = eventPublisher
        self.chatData = chatData
        self.logger = logger
    }
}
