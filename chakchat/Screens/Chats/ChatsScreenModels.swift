//
//  ChatsScreenModels.swift
//  chakchat
//
//  Created by Кирилл Исаев on 26.02.2025.
//

import Foundation

enum ChatsModels {
    
    enum GeneralChatModel {
        
        struct ChatsData: Codable {
            let chats: [ChatData]
        }
        
        struct ChatData: Codable {
            let chatID: UUID
            let type: ChatType
            let secret: Bool
            let name: String
            let chatPhoto: URL?
            let lastUpdateID: Int64
            let preview: [Preview]
            
            enum CodingKeys: String, CodingKey {
                case chatID = "chat_id"
                case type = "type"
                case secret = "secret"
                case name = "name"
                case chatPhoto = "chat_photo"
                case lastUpdateID = "last_update_id"
                case preview = "preview"
            }
        }
        
        struct Preview: Codable {
            let updateID: Int64
            let chatID: UUID
            let senderID: UUID
            let createdAt: String
            let content: Content?
            
            enum CodingKeys: String, CodingKey {
                case updateID = "update_id"
                case chatID = "chat_id"
                case senderID = "sender_id"
                case createdAt = "created_at"
                case content = "content"
            }
        }
        
        struct Content: Codable {
            let file: SuccessModels.UploadResponse?
            let text: String?
            let replyTo: UUID
            let forwarded: Bool
            let reactions: [Reaction]
            
            enum CodingKeys: String, CodingKey {
                case file = "file"
                case text = "text"
                case replyTo = "reply_to"
                case forwarded = "forwarded"
                case reactions = "reactions"
            }
        }
                
        struct Reaction: Codable {
            let updateID: Int64
            let chatID: UUID
            let senderID: UUID
            let createdAt: String
            let content: ReactionContent
            
            enum CodingKeys: String, CodingKey {
                case updateID = "update_id"
                case chatID = "chat_id"
                case senderID = "sender_id"
                case createdAt = "created_at"
                case content = "content"
            }
        }
        
        struct ReactionContent: Codable {
            let reaction: String
            let messageID: UUID
            
            enum CodingKeys: String, CodingKey {
                case reaction = "reaction"
                case messageID = "message_id"
            }
        }
    }
    
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
    
    enum SecretGroupChat {
        struct Response: Codable {
            let id: UUID
            let name: String
            let description: String
            let members: [UUID]
            let createdAt: String
            let adminID: UUID
            let groupPhoto: URL?
            let expiration: String
            
            enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
                case description = "description"
                case members = "members"
                case createdAt = "created_ad"
                case adminID = "admin_id"
                case groupPhoto = "group_photo"
                case expiration = "expiration"
            }
        }
    }
    
    enum UpdateModels {
        struct SendMessageRequest: Codable {
            let text: String
            let replyTo: UUID
            
            enum CodingKeys: String, CodingKey {
                case text = "text"
                case replyTo = "reply_to"
            }
        }
        
        struct EditMessageRequest: Codable {
            let text: String
            enum CodingKeys: String, CodingKey {
                case text = "text"
            }
        }
        
        
        struct FileMessageRequest: Codable {
            let fileID: UUID
            let replyTo: UUID
            
            enum CodingKeys: String, CodingKey {
                case fileID = "file_id"
                case replyTo = "reply_to"
            }
        }
        
        struct ReactionRequest: Codable {
            let reaction: String
            let messageID: UUID
            
            enum CodingKeys: String, CodingKey {
                case reaction = "reaction"
                case messageID = "message_id"
            }
        }
        
        struct ForwardMessageRequest: Codable {
            let messages: [UUID]
            let fromChatID: UUID
            
            enum CodingKeys: String, CodingKey {
                case messages = "messages"
                case fromChatID = "from_chat_id"
            }
        }
    }
    
    enum SecretUpdateModels {
        struct SendMessageRequest: Codable {
            let payload: String
            let initializationVector: String
            let keyID: UUID
            
            enum CodingKeys: String, CodingKey {
                case payload = "payload"
                case initializationVector = "initialization_vector"
                case keyID = "key_id"
            }
        }
        
        struct SecretPreview: Codable {
            let updateID: Int64
            let chatID: UUID
            let senderID: UUID
            let createdAt: String
            let content: SendMessageRequest
            
            enum CodingKeys: String, CodingKey {
                case updateID = "update_id"
                case chatID = "chat_id"
                case senderID = "sender_id"
                case createdAt = "created_at"
                case content = "content"
            }
        }
    }
}

enum DeleteMode: String {
    case onlyMe = "only_me"
    case all = "all"
}

enum ChatType: String, Codable {
    case personal = "personal"
    case personalSecret = "personal_secret"
    case group = "group"
    case groupSecret = "group_secret"
}
