//
//  FileStorageServiceProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 15.02.2025.
//

import Foundation

protocol FileStorageServiceProtocols {
    func sendFileUploadRequest(fileURL: URL,
                               fileName: String,
                               mimeType: String,
                               accessToken: String,
                               completion: @escaping (Result<SuccessModels.FileUploadResponse, Error>) -> Void
    )
}
