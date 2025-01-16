//
//  MockErrorHandler.swift
//  chakchat
//
//  Created by Кирилл Исаев on 16.01.2025.
//

import Foundation
import UIKit
final class MockErrorHandler : ErrorHandlerLogic {
    var handledError : (any Error)?
    func handleError(_ error: any Error) {
        handledError = error
    }
}

