//
//  ChatsScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import UIKit

// MARK: - ChatsScreenBusinessLogic
protocol ChatsScreenBusinessLogic {
    func routeToSettingsScreen()
    func createSearchResultVC() -> UIViewController
}

// MARK: - ChatsScreenPresentationLogic
protocol ChatsScreenPresentationLogic {
    
}

// MARK: - ChatsScreenWorkerLogic
protocol ChatsScreenWorkerLogic {
    
}
