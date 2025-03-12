//
//  GroupChatProfileInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import UIKit
import OSLog
import Combine

final class GroupChatProfileInteractor: GroupChatProfileBusinessLogic {
    
    private let presenter: GroupChatProfilePresentationLogic
    private let worker: GroupChatProfileWorkerLogic
    private let errorHandler: ErrorHandlerLogic
    private let chatData: ChatsModels.GeneralChatModel.ChatData
    private let eventManager: (EventPublisherProtocol & EventSubscriberProtocol)
    private let logger: OSLog
    
    private var cancellables = Set<AnyCancellable>()
    
    var onRouteToChatMenu: (() -> Void)?
    var onRouteToEdit: ((GroupProfileEditModels.ProfileData) -> Void)?
    var onRouteBack: (() -> Void)?
    
    init(
        presenter: GroupChatProfilePresentationLogic,
        worker: GroupChatProfileWorkerLogic,
        errorHandler: ErrorHandlerLogic,
        chatData: ChatsModels.GeneralChatModel.ChatData,
        eventManager: (EventPublisherProtocol & EventSubscriberProtocol),
        logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.errorHandler = errorHandler
        self.chatData = chatData
        self.eventManager = eventManager
        self.logger = logger
        
        subscribeToEvents()
    }
    
    func passChatData() {
        let myID = getMyID()
        if case .group(let groupInfo) = chatData.info {
            let isAdmin = myID == groupInfo.admin
            presenter.passChatData(chatData, isAdmin)
        }
    }
    
    func deleteGroup() {
        worker.deleteGroup(chatData.chatID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                os_log("Group with id: %@ deleted", log: logger, type: .default, chatData.chatID as CVarArg)
                let event = DeletedChatEvent(chatID: chatData.chatID)
                eventManager.publish(event: event)
                routeToChatMenu()
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to delete group with id: %@", log: logger, type: .fault, chatData.chatID as CVarArg)
                print(failure)
            }
        }
    }
    
    func addMember(_ memberID: UUID) {
        worker.addMember(chatData.chatID, memberID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                os_log("Member with id: %@ added in group(%@)", log: logger, type: .default, memberID as CVarArg, chatData.chatID as CVarArg)
                let event = AddedMemberEvent(memberID: memberID)
                eventManager.publish(event: event)
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to add member with id: %@ in group(%@)", log: logger, type: .default, memberID as CVarArg, chatData.chatID as CVarArg)
                print(failure)
            }
        }
    }
    
    func deleteMember(_ memberID: UUID) {
        worker.deleteMember(chatData.chatID, memberID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                os_log("Member with id: %@ deleted from group(%@)", log: logger, type: .default,
                       memberID as CVarArg, chatData.chatID as CVarArg)
                let event = DeletedMemberEvent(memberID: memberID)
                eventManager.publish(event: event)
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to delete member with id: %@ from group(%@)", log: logger, type: .default, memberID as CVarArg, chatData.chatID as CVarArg)
                print(failure)
            }
        }
    }
    
    func updateGroupInfo(_ name: String, _ description: String?) {
        presenter.updateGroupInfo(name, description)
    }
    
    func updateGroupPhoto(_ image: UIImage?) {
        presenter.updateGroupPhoto(image)
    }
    
    func handleUpdatedGroupInfoEvent(_ event: UpdatedGroupInfoEvent) {
        DispatchQueue.main.async {
            self.updateGroupInfo(event.name, event.description)
        }
    }
    
    func handleUpdatedGroupPhotoEvent(_ event: UpdatedGroupPhotoEvent) {
        DispatchQueue.main.async {
            self.updateGroupPhoto(event.photo)
        }
    }
    
    private func subscribeToEvents() {
        eventManager.subscribe(UpdatedGroupInfoEvent.self) { [weak self] event in
            self?.handleUpdatedGroupInfoEvent(event)
        }.store(in: &cancellables)
        eventManager.subscribe(UpdatedGroupPhotoEvent.self) { [weak self] event in
            self?.handleUpdatedGroupPhotoEvent(event)
        }.store(in: &cancellables)
    }
    
    func fetchUsers(_ name: String?, _ username: String?, _ page: Int, _ limit: Int, completion: @escaping (Result<ProfileSettingsModels.Users, any Error>) -> Void) {
        worker.fetchUsers(name, username, page, limit) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getUserDataByID(_ users: [UUID], completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, any Error>) -> Void) {
        worker.getUserDataByID(users) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func handleError(_ error: any Error) {
        _ = errorHandler.handleError(error)
        os_log("Failure:", log: logger, type: .fault)
        print(error)
    }
    
    //MARK: - Routing
    func routeToEdit() {
        if case .group(let groupInfo) = chatData.info {
            let dataToEdit = GroupProfileEditModels.ProfileData(
                chatID: chatData.chatID,
                name: groupInfo.name,
                description: groupInfo.description,
                photoURL: groupInfo.groupPhoto
            )
            onRouteToEdit?(dataToEdit)
        }
    }
    
    func routeToChatMenu() {
        onRouteToChatMenu?()
    }
    
    func routeBack() {
        onRouteBack?()
    }
    //MARK: - Top secret methods
    private func getMyID() -> UUID {
        let myID = worker.getMyID()
        return myID
    }
}
