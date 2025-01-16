//
//  MockSender.swift
//  chakchat
//
//  Created by Кирилл Исаев on 16.01.2025.
//

import Foundation
import UIKit


class MockSender {
    
    var result: Result<Data, Error>?
    
    func send<T, U>(requestBody: T, responseType: U.Type, endpoint: String, completion: @escaping (Result<U, any Error>) -> Void) where T : Decodable, T : Encodable, U : Decodable, U : Encodable {
        if let result = result as? Result<U, any Error> {
            completion(result)
        }
    }
    
}
