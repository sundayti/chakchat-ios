//
//  GroupChatProfilePresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation

final class GroupChatProfilePresenter: GroupChatProfilePresentationLogic {
    weak var view: GroupChatProfileViewController?
    
    func passChatData(_ chatData: ChatsModels.GroupChat.Response) {
        view?.configureWithUserData(chatData)
    }
}
