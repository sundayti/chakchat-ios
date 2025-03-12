//
//  GroupChatProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation

protocol GroupChatBusinessLogic: SendingMessagesProtocol {
    func routeBack()
    func passChatData()
    func handleAddedMemberEvent(_ event: AddedMemberEvent)
    func handleDeletedMemberEvent(_ event: DeletedMemberEvent)
}

protocol GroupChatPresentationLogic {
    func passChatData(_ chatData: ChatsModels.GroupChat.Response)
}

protocol GroupChatWorkerLogic {
    func sendTextMessage(_ message: String)
}
