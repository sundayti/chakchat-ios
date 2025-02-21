//
//  UsersSearchProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.02.2025.
//

import Foundation

protocol UsersSearchBusinessLogic {
    func showUsers(_ users: ProfileSettingsModels.Users)
    func fetchUsers(_ name: String?, _ username: String?, _ page: Int, _ limit: Int)
}

protocol UsersSearchPresentationLogic {
    func showUsers(_ users: ProfileSettingsModels.Users)
}

protocol UsersSearchWorkerLogic {
    func fetchUsers(
        _ name: String?,
        _ username: String?,
        _ page: Int,
        _ limit: Int,
        completion: @escaping (Result<ProfileSettingsModels.Users, Error>) -> Void
    )
}
