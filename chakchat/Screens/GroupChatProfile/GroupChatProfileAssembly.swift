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
        let worker = GroupChatProfileWorker(keychainManager: context.keychainManager)
        let interactor = GroupChatProfileInteractor(presenter: presenter, worker: worker)
        let view = GroupChatProfileViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
