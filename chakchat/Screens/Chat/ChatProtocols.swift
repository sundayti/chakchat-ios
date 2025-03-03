//
//  ChatProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import Foundation

protocol ChatBusinessLogic {
    func routeBack()
    func createChat(_ memberID: UUID)
}

protocol ChatPresentationLogic {
    
}

protocol ChatWorkerLogic {
    func createChat(_ memberID: UUID, completion: @escaping (Result<ChatsModels.PersonalChat.Response, Error>) -> Void)
}
