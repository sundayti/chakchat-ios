//
//  FileStorageService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 15.02.2025.
//

import Foundation

final class FileStorageService: FileStorageServiceProtocols {
    func sendFileUploadRequest(fileURL: URL, fileName: String, mimeType: String, accessToken: String, completion: @escaping (Result<SuccessModels.FileUploadResponse, any Error>) -> Void) {
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
}

