//
//  SenderProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 16.01.2025.
//

import Foundation
import UIKit
protocol SenderLogic {
    
    static func send<T: Codable, U: Codable>(
        requestBody: T,
        responseType: U.Type,
        endpoint: String,
        completion: @escaping (Result<U, Error>) -> Void
    )
}
