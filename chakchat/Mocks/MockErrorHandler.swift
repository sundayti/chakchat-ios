//
//  MockErrorHandler.swift
//  chakchat
//
//  Created by Кирилл Исаев on 16.01.2025.
//

import Foundation

// MARK: - MockErrorHandler
final class MockErrorHandler: ErrorHandlerLogic {
    
    // MARK: - Properties
    var handledError: (any Error)?
    
    // MARK: - Error Handling
    func handleError(_ error: any Error) -> ErrorId {
        handledError = error
        return ErrorId(message: nil, type: ErrorOutput.None)
    }
}

