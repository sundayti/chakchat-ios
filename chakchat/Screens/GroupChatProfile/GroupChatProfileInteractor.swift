//
//  GroupChatProfileInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation

final class GroupChatProfileInteractor: GroupChatProfileBusinessLogic {
    private let presenter: GroupChatProfilePresentationLogic
    private let worker: GroupChatProfileWorkerLogic
    
    init(presenter: GroupChatProfilePresentationLogic, worker: GroupChatProfileWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}
