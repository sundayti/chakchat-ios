//
//  ChatsScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import UIKit

// MARK: - ChatsScreenBusinessLogic
protocol ChatsScreenBusinessLogic: SearchInteractor {
    func loadMeData()
    func loadMeRestrictions()
    func routeToSettingsScreen()
    func routeToNewMessageScreen()
}

// MARK: - ChatsScreenPresentationLogic
protocol ChatsScreenPresentationLogic {
    
}

// MARK: - ChatsScreenWorkerLogic
protocol ChatsScreenWorkerLogic {
    func loadMeData(competion: @escaping (Result<Void, Error>) -> Void)
    func loadMeRestrictions(completion: @escaping (Result<Void, Error>) -> Void)
    
    func fetchUsers(
        _ name: String?,
        _ username: String?,
        _ page: Int,
        _ limit: Int,
        completion: @escaping (Result<ProfileSettingsModels.Users, Error>) -> Void
    )
}

protocol SearchInteractor {
    func fetchUsers(_ name: String?, _ username: String?, _ page: Int, _ limit: Int, completion: @escaping (Result<ProfileSettingsModels.Users, Error>) -> Void)
    
    func handleError(_ error: Error)
}
