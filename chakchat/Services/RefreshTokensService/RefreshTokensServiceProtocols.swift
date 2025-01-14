//
//  RefreshTokensServiceProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 14.01.2025.
//

import Foundation
import UIKit
protocol RefreshTokensServiceLogic {
    func sendRefreshTokensRequest(_ request: Refresh.RefreshRequest, completion: @escaping (Result<SuccessModels.Tokens, Error>) -> Void)
}
