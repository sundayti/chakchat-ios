//
//  Sender.swift
//  chakchat
//
//  Created by Кирилл Исаев on 10.01.2025.
//

import Foundation

// MARK: - Sender
final class Sender: SenderLogic {
    
    enum Keys {
        static let baseURL = "SERVER_BASE_URL"
    }
    
    static func Get<T, U>(requestBody: T? = nil, 
                          responseType: U.Type,
                          endpoint: String, 
                          completion: @escaping (Result<U, any Error>) -> Void
    ) where T : Decodable, T : Encodable, U : Decodable, U : Encodable {
        send(requestBody: requestBody,
             responseType: responseType,
             endpoint: endpoint,
             httpMethod: "GET",
             completion: completion)
    }
    
    static func Put<T, U>(requestBody: T, 
                          responseType: U.Type,
                          endpoint: String,
                          completion: @escaping (Result<U, any Error>) -> Void
    ) where T : Decodable, T : Encodable, U : Decodable, U : Encodable {
        send(requestBody: requestBody,
             responseType: responseType,
             endpoint: endpoint,
             httpMethod: "PUT",
             completion: completion)
    }
    
    static func Post<T, U>(requestBody: T, 
                           responseType: U.Type,
                           endpoint: String,
                           completion: @escaping (Result<U, any Error>) -> Void
    ) where T : Decodable, T : Encodable, U : Decodable, U : Encodable {
        send(requestBody: requestBody,
             responseType: responseType,
             endpoint: endpoint,
             httpMethod: "POST",
             completion: completion)
    }
    
    static func Delete<T, U>(requestBody: T, 
                             responseType: U.Type,
                             endpoint: String,
                             completion: @escaping (Result<U, any Error>) -> Void
    ) where T : Decodable, T : Encodable, U : Decodable, U : Encodable {
        send(requestBody: requestBody, 
             responseType: responseType,
             endpoint: endpoint,
             httpMethod: "DELETE",
             completion: completion)
    }
    
    // MARK: - Sender Method
    private static func send<T: Codable, U: Codable>(
        requestBody: T? = nil,
        responseType: U.Type,
        endpoint: String,
        httpMethod: String,
        completion: @escaping (Result<U, Error>) -> Void
    ) {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: Keys.baseURL) as? String else {
            fatalError("miss base url")
        }
        
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //TODO: Разобраться с ключами
        if (httpMethod == "POST") {
            request.addValue(UUID().uuidString, forHTTPHeaderField: "Idempotency-Key")
        }
        
        
        guard let httpBody = try? JSONEncoder().encode(requestBody) else {
            completion(.failure(APIError.invalidRequest))
            return
        }
        
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(APIError.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                do {
                    let responseData = try JSONDecoder().decode(SuccessResponse<U>.self, from: data)
                    completion(.success(responseData.data))
                } catch {
                    completion(.failure(APIError.decodingError(error)))
                }
            default:
                do {
                    let errorResponse = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                    completion(.failure(APIErrorResponse(errorType: errorResponse.errorType,
                                                         errorMessage: errorResponse.errorMessage,
                                                         errorDetails: errorResponse.errorDetails)))
                } catch {
                    completion(.failure(APIError.decodingError(error)))
                }
            }
        }
        task.resume()
    }
}

// MARK: - SuccessResponse
struct SuccessResponse<T: Codable>: Codable {
    let data: T
}
