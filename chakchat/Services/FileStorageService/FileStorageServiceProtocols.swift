//
//  FileStorageServiceProtocols.swift
//  chakchat
//
//  Created by лизо4ка курунок on 16.02.2025.
//

import Foundation

protocol FileStorageServiceProtocols {
    func sendFileUploadRequest(_ fileURL: URL,
                               _ fileName: String,
                               _ mimeType: String,
                               _ accessToken: String,
                               completion: @escaping (Result<SuccessModels.UploadResponse, Error>) -> Void
    )
    
    func sendFileUploadInitRequest(_ request: FileStorageRequest.UploadInit,
                                   _ accessToken: String,
                                   completion: @escaping (Result<SuccessModels.UploadInitResponse, Error>) -> Void)
    
    func sendFileUploadPartRequest(_ partNumber: Int,
                                   _ uploadID: UUID,
                                   _ fileData: Data,
                                   _ accessToken: String, completion: @escaping (Result<SuccessModels.UploadPartResponse, Error>) -> Void)
    
    func sendFileUploadAbortRequest(_ request: FileStorageRequest.UploadAbort,
                                    _ accessToken: String,
                                    completion: @escaping (Result<SuccessModels.EmptyResponse, Error>) -> Void)
    
    func sendFileUploadCompleteRequest(_ request: FileStorageRequest.UploadComplete,
                                       _ accessToken: String,
                                       completion: @escaping (Result<SuccessModels.UploadResponse, Error>) -> Void)
    
    func sendGetFileRequest(_ fileID: UUID, _ accessToken: String, completion: @escaping (Result<SuccessModels.UploadResponse, Error>) -> Void)
}
