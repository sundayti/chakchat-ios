//
//  RefreshTokensServiceProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 14.01.2025.
//

import Foundation

// MARK: - RefreshTokensServiceLogic
protocol RefreshTokensServiceLogic {
    func sendRefreshTokensRequest(_ request: Refresh.RefreshRequest, completion: @escaping (Result<SuccessModels.Tokens, Error>) -> Void)
}
