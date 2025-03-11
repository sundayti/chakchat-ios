//
//  ChatsScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation

// MARK: - ChatsScreenPresenter
final class ChatsScreenPresenter: ChatsScreenPresentationLogic {

    weak var view: ChatsScreenViewController?
    
    func showChats(_ chats: ChatsModels.GeneralChatModel.ChatsData) {
        view?.showChats(chats)
    }
    
    func addNewChat(_ chatData: ChatsModels.GeneralChatModel.ChatData) {
        view?.addNewChat(chatData)
    }
}
