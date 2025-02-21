//
//  MeService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.02.2025.
//

import Foundation
/// пока что здесь закомменчены настоящие реализации запроса к серверу и работают только моки
final class UserService: UserServiceProtocol {
    func sendGetMeRequest(_ accessToken: String, completion: @escaping (Result<SuccessResponse<ProfileSettingsModels.ProfileUserData>, any Error>) -> Void) {
//        let endpoint = UserServiceEndpoints.me.rawValue
//        
//        let headers = [
//            "Authorization": "Bearer \(accessToken)",
//            "Content-Type": "application/json"
//        ]
//        
//        Sender.send(endpoint: endpoint, method: .get, headers: headers, completion: completion)
        completion(
            .success(
                SuccessResponse<ProfileSettingsModels.ProfileUserData>(
                    data: ProfileSettingsModels.ProfileUserData(
                        id: UUID(),
                        name: "Mockname",
                        username: "Mockusername",
                        phone: "79776002210",
                        photo: nil,
                        dateOfBirth: "21.05.2025"
                    )
                )
            )
        )
    }
    
    func sendPutMeRequest(_ request: ProfileSettingsModels.ChangeableProfileUserData,
                          _ accessToken: String,
                          completion: @escaping (Result<SuccessResponse<ProfileSettingsModels.ProfileUserData>, any Error>) -> Void) {
//        let endpoint = UserServiceEndpoints.me.rawValue
//        
//        let body = try? JSONEncoder().encode(request)
//        
//        let headers = [
//            "Authorization": "Bearer \(accessToken)",
//            "Content-Type": "application/json"
//        ]
//        
//        Sender.send(endpoint: endpoint, method: .put, headers: headers, body: body, completion: completion)
        completion(
            .success(
                SuccessResponse<ProfileSettingsModels.ProfileUserData>(
                    data: ProfileSettingsModels.ProfileUserData(
                        id: UUID(),
                        name: "NewMockname",
                        username: "NewMockusername",
                        phone: "79776002211",
                        photo: nil,
                        dateOfBirth: "19.05.2025"
                    )
                )
            )
        )
    }
    
    func sendGetRestrictionRequest(_ accessToken: String,
                                   completion: @escaping (Result<SuccessResponse<ConfidentialitySettingsModels.ConfidentialityUserData>, any Error>) -> Void) {
//        let endpoint = UserServiceEndpoints.meRestrictions.rawValue
//        
//        let headers = [
//            "Authorization": "Bearer \(accessToken)",
//            "Content-Type": "application/json"
//        ]
//        
//        Sender.send(endpoint: endpoint, method: .get, headers: headers, completion: completion)
        completion(
            .success(
                SuccessResponse<ConfidentialitySettingsModels.ConfidentialityUserData>(
                    data: ConfidentialitySettingsModels.ConfidentialityUserData(
                        phone: ConfidentialityDetails(openTo: "everyone", specifiedUsers: nil),
                        dateOfBirth: ConfidentialityDetails(openTo: "only_me", specifiedUsers: nil)
                    )
                )
            )
        )
    }
    
    func sendPutRestrictionRequest(_ request: ConfidentialitySettingsModels.ConfidentialityUserData,
                                   _ accessToken: String,
                                   completion: @escaping (Result<SuccessResponse<EmptyResponse>, any Error>) -> Void) {
//        let endpoint = UserServiceEndpoints.meRestrictions.rawValue
//        
//        let body = try? JSONEncoder().encode(request)
//        
//        let headers = [
//            "Authorization": "Bearer \(accessToken)",
//            "Content-Type": "application/json"
//        ]
//        
//        Sender.send(endpoint: endpoint, method: .put, headers: headers, body: body, completion: completion)
        completion(
            .success(
                SuccessResponse<EmptyResponse>(
                    data: EmptyResponse()
                )
            )
        )
    }
    
    func sendGetUsersRequest(_ name: String?, _ username: String?, _ page: Int, _ limit: Int, _ accessToken: String, completion: @escaping (Result<SuccessResponse<ProfileSettingsModels.Users>, any Error>) -> Void) {
//        let endpoint = UserServiceEndpoints.users.rawValue
//        var components = URLComponents(string: endpoint)
//        var queryItems: [URLQueryItem] = []
//        if let name = name {
//            queryItems.append(URLQueryItem(name: "name", value: name))
//        }
//        if let username = username {
//            queryItems.append(URLQueryItem(name: "username", value: username))
//        }
//        queryItems.append(URLQueryItem(name: "page", value: String(page)))
//        queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
//        
//        components?.queryItems = queryItems
//        
//        guard let url = components?.url else {
//            completion(.failure(APIError.invalidURL))
//            return
//        }
//        
//        let endpointWithQuery = url.absoluteString
//        
//        let headers = [
//            "Authorization": "Bearer \(accessToken)",
//            "Content-Type": "application/json"
//        ]
//        
//        Sender.send(endpoint: endpointWithQuery, method: .get, headers: headers, completion: completion)
        completion(
            .success(
                SuccessResponse<ProfileSettingsModels.Users>(
                    data: ProfileSettingsModels.Users(
                        users: [
                            ProfileSettingsModels.ProfileUserData(id: UUID(), name: "Kirill", username: "mrdr", phone: "79776002210", photo: nil, dateOfBirth: "29.08.2005"),
                            ProfileSettingsModels.ProfileUserData(id: UUID(), name: "Fedor", username: "yeezus", phone: "79651838086", photo: nil, dateOfBirth: "13.05.2005"),
                            ProfileSettingsModels.ProfileUserData(id: UUID(), name: "Vanya", username: "mrdr", phone: "79167723490", photo: nil, dateOfBirth: "25.02.2005"),
                            ProfileSettingsModels.ProfileUserData(id: UUID(), name: "Yulia", username: "kykx", phone: "79772722390", photo: nil, dateOfBirth: "29.08.2005"),
                            ProfileSettingsModels.ProfileUserData(id: UUID(), name: "Kolya", username: "kolya", phone: "79410422300", photo: nil, dateOfBirth: "23.12.2005"),
                            ProfileSettingsModels.ProfileUserData(id: UUID(), name: "Liza", username: "lzkgmr", phone: "79289120023", photo: nil, dateOfBirth: "18.04.2003"),
                            ProfileSettingsModels.ProfileUserData(id: UUID(), name: "Asshat", username: "justpuice", phone: "79238926740", photo: nil, dateOfBirth: "13.11.2005"),
                            ProfileSettingsModels.ProfileUserData(id: UUID(), name: "Vlad", username: "nepomny", phone: "79223926740", photo: nil, dateOfBirth: "02.06.2005"),
                            ProfileSettingsModels.ProfileUserData(id: UUID(), name: "Bulat", username: "sunyysh", phone: "79223924740", photo: nil, dateOfBirth: "12.10.2005"),
                        ]
                    )
                )
            )
        )
    }
}

struct EmptyResponse: Codable {}
