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
    
    func addNewChat(_ chatData: ChatsModels.PersonalChat.Response) {
        view?.addNewChat(chatData)
    }
    
    func showChats(_ chats: [ChatsModels.PersonalChat.Response]?) {
        view?.showChats(chats)
    }
}
