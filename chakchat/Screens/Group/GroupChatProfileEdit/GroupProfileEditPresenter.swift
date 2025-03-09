//
//  GroupProfileEditPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation

final class GroupProfileEditPresenter: GroupProfileEditPresentationLogic {
    weak var view: GroupProfileEditViewController?
    
    func passChatData(_ chatData: GroupProfileEditModels.ProfileData) {
        view?.configureWithData(chatData)
    }
}
