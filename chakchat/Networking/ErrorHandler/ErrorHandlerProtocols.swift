//
//  ErrorHandlerProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 16.01.2025.
//

import Foundation

// MARK: - ErrorHandlerLogic
protocol ErrorHandlerLogic {
    func handleError(_ error: Error) -> ErrorId
}
