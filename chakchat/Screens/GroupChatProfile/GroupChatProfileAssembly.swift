//
//  GroupChatProfileAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import UIKit

enum GroupChatProfileAssembly {
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator, _ chatData: ChatsModels.GroupChat.Response) -> UIViewController {
        let presenter = GroupChatProfilePresenter()
        let groupService = GroupChatService()
        let worker = GroupChatProfileWorker(
            keychainManager: context.keychainManager,
            groupService: groupService
        )
        let interactor = GroupChatProfileInteractor(
            presenter: presenter,
            worker: worker,
            errorHandler: context.errorHandler,
            chatData: chatData,
            eventPublisher: context.eventManager,
            logger: context.logger
        )
        interactor.onRouteToChatMenu = { [weak coordinator] in
            coordinator?.finishSignupFlow()
        }
        interactor.onRouteBack = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = GroupChatProfileViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
