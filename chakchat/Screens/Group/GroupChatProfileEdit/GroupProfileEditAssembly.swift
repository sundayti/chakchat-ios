//
//  GroupProfileEditAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import UIKit

enum GroupProfileEditAssembly {
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator, _ chatData: GroupProfileEditModels.ProfileData) -> UIViewController {
        let presenter = GroupProfileEditPresenter()
        let groupService = GroupChatService()
        let worker = GroupProfileEditWorker(
            keychainManager: context.keychainManager,
            groupService: groupService,
            coreDataManager: context.coreDataManager
        )
        let interactor = GroupProfileEditInteractor(
            presenter: presenter,
            worker: worker,
            errorHandler: context.errorHandler,
            eventPublisher: context.eventManager,
            chatData: chatData,
            logger: context.logger
        )
        let view = GroupProfileEditViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
