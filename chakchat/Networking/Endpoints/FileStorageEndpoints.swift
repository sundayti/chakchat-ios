//
//  FileStorageEndpoints.swift
//  chakchat
//
//  Created by Кирилл Исаев on 16.02.2025.
//

import Foundation

enum FileStorageEndpoints: String {
    case upload = "/api/file-storage/v1.0/upload"
    case uploadMultipartInit = "/api/file-storage/v1.0/upload/multipart/init"
    case uploadMultipartPart = "/api/file-storage/v1.0/upload/multipart/part"
    case uploadMultipartAbort = "/api/file-storage/v1.0/upload/multipart/abort"
    case uploadMultipartComplete = "/api/file-storage/v1.0/upload/multipart/complete"
    
    case getFileMetadata = "/api/file-storage/v1.0/file/"
}
