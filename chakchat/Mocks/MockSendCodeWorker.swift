//
//  SendCodeWorkerMock.swift
//  chakchat
//
//  Created by Кирилл Исаев on 16.01.2025.
//

import Foundation

// MARK: - MockWorker
final class MockWorker: SendCodeWorkerLogic {
    
    // MARK: - Properties
    var result: Result<AppState, Error>?
    
    // MARK: - Requests Handling
    func sendInRequest(_ request: SendCodeModels.SendCodeRequest, completion: @escaping (Result<AppState, any Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
    
    func sendUpRequest(_ request: SendCodeModels.SendCodeRequest, completion: @escaping (Result<AppState, any Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
