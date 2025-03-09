//
//  GroupChatAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import UIKit

enum GroupChatAssembly {
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = GroupChatPresenter()
        let worker = GroupChatWorker()
        let interactor = GroupChatInteractor(presenter: presenter, worker: worker)
        let view = GroupChatViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
