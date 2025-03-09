//
//  MeService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.02.2025.
//

import Foundation
import Combine

/// пока что здесь закомменчены настоящие реализации запроса к серверу и работают только стабы
final class UserService: UserServiceProtocol {
 
    func sendGetUserRequest(_ userID: UUID, _ accessToken: String, completion: @escaping (Result<SuccessResponse<ProfileSettingsModels.ProfileUserData>, any Error>) -> Void) {
        let endpoint = "\(UserServiceEndpoints.user.rawValue)\(userID)"
        
        let headers = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .get, headers: headers, completion: completion)
    }
    
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
                        id: UUID(uuidString: "2ED634A9-4DA0-46ED-B1FD-9CC266523CFD") ?? UUID(),
                        name: "Kirill",
                        username: "mrdr",
                        phone: "79776002210",
                        photo: nil,
                        dateOfBirth: "29.08.2005",
                        createdAt: Date()
                    )
                )
            )
        )
    }
    
    func sendPutMeRequest(_ request: ProfileSettingsModels.ChangeableProfileUserData,
                          _ accessToken: String,
                          completion: @escaping (Result<SuccessResponse<ProfileSettingsModels.ProfileUserData>, any Error>) -> Void) {
        let endpoint = UserServiceEndpoints.me.rawValue
        
        let body = try? JSONEncoder().encode(request)
        
        let headers = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .put, headers: headers, body: body, completion: completion)

    }
    
    func sendGetRestrictionRequest(_ accessToken: String,
                                   completion: @escaping (Result<SuccessResponse<ConfidentialitySettingsModels.ConfidentialityUserData>, any Error>) -> Void) {
        let endpoint = UserServiceEndpoints.meRestrictions.rawValue
        
        let headers = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .get, headers: headers, completion: completion)
    }
    
    func sendPutRestrictionRequest(_ request: ConfidentialitySettingsModels.ConfidentialityUserData,
                                   _ accessToken: String,
                                   completion: @escaping (Result<SuccessResponse<EmptyResponse>, any Error>) -> Void) {
        let endpoint = UserServiceEndpoints.meRestrictions.rawValue
        
        let body = try? JSONEncoder().encode(request)
        
        let headers = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .put, headers: headers, body: body, completion: completion)
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
                            ProfileSettingsModels.ProfileUserData(
                                id: UUID(uuidString: "3972C009-F73D-438C-A953-242E6DBE472C") ?? UUID(),
                                name: "Yulia",
                                username: "kykx",
                                phone: "79772722390",
                                photo: nil,
                                dateOfBirth: "29.08.2005",
                                createdAt: Date()
                            ),
                            ProfileSettingsModels.ProfileUserData(
                                id: UUID(uuidString: "4EA6CE4F-E81F-4940-938E-C5309A5B2886") ?? UUID(),
                                name: "Fedya",
                                username: "pipecall",
                                phone: "79651838086",
                                photo: nil,
                                dateOfBirth: "13.05.2005",
                                createdAt: Date()
                            ),
                            ProfileSettingsModels.ProfileUserData(id: UUID(uuidString: "5E7CB0A7-E92D-46DC-939E-DAAEAEE6001C") ?? UUID(), name: "Vanya", username: "wartigan", phone: "79852602436", photo: nil, dateOfBirth: "25.02.2005", createdAt: Date()),
                            ProfileSettingsModels.ProfileUserData(id: UUID(uuidString: "3CC67FC4-227C-4CAF-A7B4-0863019FB393") ?? UUID(), name: "Kolya", username: "random", phone: "79251985423", photo: nil, dateOfBirth: "26.12.2005", createdAt: Date()),
                            ProfileSettingsModels.ProfileUserData(id: UUID(uuidString: "A03CDC5D-1659-449B-B6EA-593260C73B1A") ?? UUID(), name: "Liza", username: "lzkgmr", phone: "79164905214", photo: nil, dateOfBirth: "18.04.2003", createdAt: Date()),
                            ProfileSettingsModels.ProfileUserData(id: UUID(uuidString: "6E82FD04-67F6-4C1A-96E1-1B870BD4EF7F") ?? UUID(), name: "Bulat", username: "sunnyyssh", phone: "79033061099", photo: nil, dateOfBirth: "12.10.2005", createdAt: Date()),
                            ProfileSettingsModels.ProfileUserData(id: UUID(uuidString: "948CD307-9D3D-42DD-844A-EB4F2EA19142") ?? UUID(), name: "Anya", username: "taiga", phone: "79167313908", photo: nil, dateOfBirth: "12.06.2005", createdAt: Date()),
                            ProfileSettingsModels.ProfileUserData(id: UUID(uuidString: "8DC4F45E-57A7-425A-911D-198FBB1FF865") ?? UUID(), name: "Asshat", username: "justcipunz", phone: "79514223246", photo: nil, dateOfBirth: "13.11.2005", createdAt: Date()),
                            ProfileSettingsModels.ProfileUserData(id: UUID(uuidString: "3E6E5C76-5202-47AE-9CD3-F84C41E48422") ?? UUID(), name: "Vlad", username: "Zattox", phone: "79308097097", photo: nil, dateOfBirth: "02.06.2005", createdAt: Date())
                        ]
                    )
                )
            )
        )
    }
    /// нужен для поиска по username в бд, чтобы понимать, может ли пользователь использовать такой username или нет
    /// пока что сделал стаб, в дальнейшем должно работать нормально
    /// в текущий момент если пользователь пытается поставить username = eusername, что
    /// идеалогически означает existing username, то ему выдается информация про этого пользователя,
    /// т е ответ 200.
    /// в противном случае ему вылетает ошибка userNotFound.
    /// валидатор нужен чтобы проверять, не ввел ли пользователь некорректный username
    func sendGetUsernameRequest(_ username: String, _ accessToken: String, completion: @escaping (Result<SuccessResponse<ProfileSettingsModels.ProfileUserData>, any Error>) -> Void) {
        let endpoint = "\(UserServiceEndpoints.username.rawValue)\(username)"
        
        let headers = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .get, headers: headers, completion: completion)
    }
    
    func sendPutPhotoRequest(_ request: ProfileSettingsModels.NewPhotoRequest, _ accessToken: String, completion: @escaping (Result<SuccessResponse<ProfileSettingsModels.ProfileUserData>, any Error>) -> Void) {
//        let endpoint = UserServiceEndpoints.photo.rawValue
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
                        name: "",
                        username: "",
                        phone: "",
                        photo: nil,
                        dateOfBirth: nil,
                        createdAt: Date()
                    )
                )
            )
        )
    }
    
    func sendDeletePhotoRequest(_ accessToken: String, completion: @escaping (Result<SuccessResponse<ProfileSettingsModels.ProfileUserData>, any Error>) -> Void) {
//        let endpoint = UserServiceEndpoints.photo.rawValue
//        
//        let headers = [
//            "Authorization": "Bearer \(accessToken)",
//            "Content-Type": "application/json"
//        ]
//        
//        Sender.send(endpoint: endpoint, method: .delete, headers: headers, completion: completion)
        completion(
            .success(
                SuccessResponse<ProfileSettingsModels.ProfileUserData>(
                    data: ProfileSettingsModels.ProfileUserData(
                        id: UUID(),
                        name: "PhotoDeleted",
                        username: "PhotoDeleted",
                        phone: "79776002211",
                        photo: nil,
                        dateOfBirth: "29.08.2003",
                        createdAt: Date()
                    )
                )
            )
        )
    }
    
    func DONTSENDIT(completion: @escaping (Result<SuccessResponse<EmptyResponse>, any Error>) -> Void) {
        let endpoint = UserServiceEndpoints.teapot.rawValue
        Sender.send(endpoint: endpoint, method: .get, completion: completion)
    }
}

struct EmptyResponse: Codable {}
