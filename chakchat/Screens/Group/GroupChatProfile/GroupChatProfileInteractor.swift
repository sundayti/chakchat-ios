//
//  GroupChatProfileInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation
import OSLog

final class GroupChatProfileInteractor: GroupChatProfileBusinessLogic {
    
    private let presenter: GroupChatProfilePresentationLogic
    private let worker: GroupChatProfileWorkerLogic
    private let errorHandler: ErrorHandlerLogic
    private let chatData: ChatsModels.GroupChat.Response
    private let eventPublisher: EventPublisherProtocol
    private let logger: OSLog
    
    var onRouteToChatMenu: (() -> Void)?
    var onRouteToEdit: ((GroupProfileEditModels.ProfileData) -> Void)?
    var onRouteBack: (() -> Void)?
    
    init(
        presenter: GroupChatProfilePresentationLogic,
        worker: GroupChatProfileWorkerLogic,
        errorHandler: ErrorHandlerLogic,
        chatData: ChatsModels.GroupChat.Response,
        eventPublisher: EventPublisherProtocol,
        logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.errorHandler = errorHandler
        self.chatData = chatData
        self.eventPublisher = eventPublisher
        self.logger = logger
    }
    
    func passChatData() {
        let myID = getMyID()
        let isAdmin = myID == chatData.adminID
        presenter.passChatData(chatData, isAdmin)
    }
    
    func deleteGroup() {
        worker.deleteGroup(chatData.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                // делаем ивент по удалению группы
                os_log("Group with id: %@ deleted", log: logger, type: .default, chatData.id as CVarArg)
                routeToChatMenu()
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to delete group with id: %@", log: logger, type: .fault, chatData.id as CVarArg)
                print(failure)
            }
        }
    }
    
    func addMember(_ memberID: UUID) {
        worker.addMember(chatData.id, memberID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                // делаем ивент по добавлению участника
                os_log("Member with id: %@ added in group(%@)", log: logger, type: .default, memberID as CVarArg, chatData.id as CVarArg)
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to add member with id: %@ in group(%@)", log: logger, type: .default, memberID as CVarArg, chatData.id as CVarArg)
                print(failure)
            }
        }
    }
    
    func deleteMember(_ memberID: UUID) {
        worker.deleteMember(chatData.id, memberID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                // делаем ивент по удалению участника
                os_log("Member with id: %@ deleted from group(%@)", log: logger, type: .default,
                       memberID as CVarArg, chatData.id as CVarArg)
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to delete member with id: %@ from group(%@)", log: logger, type: .default, memberID as CVarArg, chatData.id as CVarArg)
                print(failure)
            }
        }
    }
    
    func routeToEdit() {
        let dataToEdit = GroupProfileEditModels.ProfileData(
            name: chatData.name,
            description: chatData.description,
            photoURL: chatData.groupPhoto
        )
        onRouteToEdit?(dataToEdit)
    }
    
    func routeToChatMenu() {
        onRouteToChatMenu?()
    }
    
    func routeBack() {
        onRouteBack?()
    }
    
    private func getMyID() -> UUID {
        let myID = worker.getMyID()
        return myID
    }
}
