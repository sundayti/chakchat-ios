//
//  ChatsScreenModels.swift
//  chakchat
//
//  Created by Кирилл Исаев on 26.02.2025.
//

import Foundation

enum ChatsModels {
    
    enum PersonalChat {
        struct CreateRequest: Codable {
            let memberID: UUID
            
            enum CodingKeys: String, CodingKey {
                case memberID = "member_id"
            }
        }
        
        struct Response: Codable {
            let chatID: UUID
            let memberID: UUID
            let blocked: Bool
            let blockedBy: [UUID]?
            
            enum CodingKeys: String, CodingKey {
                case chatID = "chat_id"
                case memberID = "member_id"
                case blocked = "blocked"
                case blockedBy = "blocked_by"
            }
        }
    }
    
    enum SecretPersonalChat {
        struct ExpirationRequest: Codable {
            let expiration: String?
        }
        
        struct Response: Codable {
            let chatID: UUID
            let memberID: UUID
            let expiration: String?
            
            enum CodingKeys: String, CodingKey {
                case chatID = "chat_id"
                case memberID = "member_id"
                case expiration = "expiration"
            }
        }
    }
    
    enum GroupChat {
        struct CreateRequest: Codable {
            let name: String
            let description: String
            let members: [UUID]
        }
        
        struct UpdateRequest: Codable {
            let name: String
            let description: String
        }
        
        struct PhotoUpdateRequest: Codable {
            let photoID: UUID
            enum CodingKeys: String, CodingKey {
                case photoID = "photo_id"
            }
        }
        
        struct Response: Codable {
            let id: UUID
            let name: String
            let description: String
            let members: [UUID]
            let createdAt: String
            let adminID: UUID
            let groupPhoto: URL?
            
            enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
                case description = "description"
                case members = "members"
                case createdAt = "created_at"
                case adminID = "admin_id"
                case groupPhoto = "group_photo"
            }
        }
    }
}

enum DeleteMode: String {
    case onlyMe = "only_me"
    case all = "all"
}
