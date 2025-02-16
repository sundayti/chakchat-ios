//
//  SenderProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 16.01.2025.
//

import Foundation

// MARK: - SenderLogic
protocol SenderLogic {
    static func send<T: Codable>(endpoint: String,
                                 method: HTTPMethod,
                                 headers: [String:String]?,
                                 body: Data?,
                                 completion: @escaping (Result<T, Error>) -> Void
    )
}
