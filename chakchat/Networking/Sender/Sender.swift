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
    
    static func send<T: Codable>(endpoint: String,
                                 method: HTTPMethod,
                                 headers: [String:String]? = nil,
                                 body: Data? = nil,
                                 completion: @escaping (Result<SuccessResponse<T>, Error>) -> Void
    ) {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: Keys.baseURL) else {
            fatalError("Cant get baseURL")
        }
        
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        // configure request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        //headers
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        //body
        request.httpBody = body
        
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
                    let responseData = try JSONDecoder().decode(SuccessResponse<T>.self, from: data)
                    completion(.success(responseData))
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

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
