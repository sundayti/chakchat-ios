//
//  GroupChatInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation

final class GroupChatInteractor: GroupChatBusinessLogic {
    private let presenter: GroupChatPresentationLogic
    private let worker: GroupChatWorkerLogic
    
    init(
        presenter: GroupChatPresentationLogic,
        worker: GroupChatWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }
}
