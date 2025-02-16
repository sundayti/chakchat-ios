//
//  FileStorageService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 15.02.2025.
//

import Foundation

final class FileStorageService: FileStorageServiceProtocols {
    
    func sendFileUploadRequest(_ fileURL: URL, _ fileName: String, _ mimeType: String, _ accessToken: String, completion: @escaping (Result<SuccessModels.UploadResponse, any Error>) -> Void) {
        let endpoint = FileStorageEndpoints.upload.rawValue
        let idempotencyKey = UUID().uuidString
        // подготовка для реквеста в случае multipart/form-data
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = Data()
        
        // специальные поля
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file_name\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(fileName)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"mime_type\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(mimeType)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        if let fileData = try? Data(contentsOf: fileURL) {
            body.append(fileData)
        }
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        let headers = [
            "Authorization": "Bearer \(accessToken)",
            "Idempotency-Key": idempotencyKey,
            "Content-Type": "multipart/form-data; boundary=\(boundary)"
        ]
        
        Sender.send(endpoint: endpoint, method: .post, headers: headers, body: body, completion: completion)
    }
    
    func sendFileUploadInitRequest(_ request: FileStorageRequest.UploadInit, _ accessToken: String, completion: @escaping (Result<SuccessModels.UploadInitResponse, any Error>) -> Void) {
        let endpoint = FileStorageEndpoints.uploadMultipartInit.rawValue
        let idempotencyKey = UUID().uuidString
        
        let body = try? JSONEncoder().encode(request)
        
        let headers = [
            "Authorization": "Bearer \(accessToken)",
            "Idempotency-Key": idempotencyKey,
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .post, headers: headers, body: body, completion: completion)
    }
    
    func sendFileUploadPartRequest(_ partNumber: Int, _ uploadID: UUID, _ fileData: Data, _ accessToken: String, completion: @escaping (Result<SuccessModels.UploadPartResponse, any Error>) -> Void) {
        let endpoint = FileStorageEndpoints.uploadMultipartPart.rawValue
        
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"part_number\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(partNumber)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"upload_id\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(uploadID)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"part\(partNumber)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        let headers = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "multipart/form-data; boundary=\(boundary)"
        ]
        
        Sender.send(endpoint: endpoint, method: .put, headers: headers, body: body, completion: completion)
    }
    
    func sendFileUploadAbortRequest(_ request: FileStorageRequest.UploadAbort, _ accessToken: String, completion: @escaping (Result<SuccessModels.EmptyResponse, any Error>) -> Void) {
        let endpoint = FileStorageEndpoints.uploadMultipartAbort.rawValue
        let idempotencyKey = UUID().uuidString
        
        let body = try? JSONEncoder().encode(request)
        
        let headers = [
            "Authorization": "Bearer \(accessToken)",
            "Idempotency-Key": idempotencyKey,
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .put, headers: headers, body: body, completion: completion)
    }
    
    func sendFileUploadCompleteRequest(_ request: FileStorageRequest.UploadComplete, _ accessToken: String, completion: @escaping (Result<SuccessModels.UploadResponse, any Error>) -> Void) {
        let endpoint = FileStorageEndpoints.uploadMultipartComplete.rawValue
        let idempotencyKey = UUID().uuidString
        
        let body = try? JSONEncoder().encode(request)
        
        let headers = [
            "Authorization": "Bearer \(accessToken)",
            "Idempotency-Key": idempotencyKey,
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .post, headers: headers, body: body, completion: completion)
    }
    
    func sendGetFileRequest(_ fileID: UUID, _ accessToken: String, completion: @escaping (Result<SuccessModels.UploadResponse, any Error>) -> Void) {
        let endpoint = "\(FileStorageEndpoints.getFileMetadata.rawValue)\(fileID)"
        //let idempotencyKey = UUID().uuidString
        
        let headers = [
            "Authorization": "Bearer \(accessToken)",
            //"Idempotency-Key": idempotencyKey,
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .post, headers: headers, completion: completion)
    }
}

enum FileStorageRequest {
    struct UploadInit: Codable {
        let fileName: String
        let mimeType: String
        
        enum CodingKeys: String, CodingKey {
            case fileName = "file_name"
            case mimeType = "mime_type"
        }
    }

    struct UploadAbort: Codable {
        let uploadID: String
        
        enum CodingKeys: String, CodingKey {
            case uploadID = "upload_id"
        }
    }

    struct UploadComplete: Codable {
        let uploadID: String
        let parts: [Part]
        
        enum CodingKeys: String, CodingKey {
            case uploadID = "upload_id"
            case parts = "parts"
        }
    }
}

struct Part: Codable {
    let partNumber: Int
    let eTag: String
    
    enum CodingKeys: String, CodingKey {
        case partNumber = "part_number"
        case eTag = "e_tag"
    }
}

