//
//  GroupProfileEditInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import UIKit
import OSLog

final class GroupProfileEditInteractor: GroupProfileEditBusinessLogic {
    private let presenter: GroupProfileEditPresentationLogic
    private let worker: GroupProfileEditWorkerLogic
    private let errorHandler: ErrorHandlerLogic
    private let eventPublisher: EventPublisherProtocol
    private let chatData: GroupProfileEditModels.ProfileData
    private let logger: OSLog
    
    var onRouteBack: (() -> Void)?
    
    init(
        presenter: GroupProfileEditPresentationLogic,
        worker: GroupProfileEditWorkerLogic,
        errorHandler: ErrorHandlerLogic,
        eventPublisher: EventPublisherProtocol,
        chatData: GroupProfileEditModels.ProfileData,
        logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.errorHandler = errorHandler
        self.eventPublisher = eventPublisher
        self.chatData = chatData
        self.logger = logger
    }
    
    func passChatData() {
        onRouteBack?()
    }
    
    func updateChat(_ name: String, _ description: String?) {
        worker.updateChat(chatData.chatID, name, description) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                // делаем ивент связанный с обновлением данных чата
                os_log("Updated data at group chat with id: %@", log: logger, type: .default, chatData.chatID as CVarArg)
                self.routeBack()
            case .failure(let failure):
                _ = self.errorHandler.handleError(failure)
                os_log("Failed to update data at group chat with id: %@", log: logger, type: .fault, chatData.chatID as CVarArg)
                print(failure)
            }
        }
    }
    
    func updateGroupPhoto(_ image: UIImage) {
        uploadFile(image) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                os_log("Upload group (%@) photo to file storage", log: logger, type: .default, chatData.chatID as CVarArg)
                worker.updateGroupPhoto(chatData.chatID, data.fileId) { result in
                    switch result {
                    case .success(_):
                        // запускаем ивент по загрузке фотки
                        os_log("Upload group (%@) photo", log: self.logger, type: .default, self.chatData.chatID as CVarArg)
                    case .failure(let failure):
                        _ = self.errorHandler.handleError(failure)
                        os_log("Failed to upload group (%@) photo", log: self.logger, type: .fault, self.chatData.chatID as CVarArg)
                        print(failure)
                    }
                }
            case .failure(let failure):
                _ = self.errorHandler.handleError(failure)
                os_log("Failed to upload group (%@) photo to file storage", log: logger, type: .fault, chatData.chatID as CVarArg)
                print(failure)
            }
        }
    }
    
    func routeBack() {
        onRouteBack?()
    }
    
    private func uploadFile(_ image: UIImage, completion: @escaping (Result<SuccessModels.UploadResponse, any Error>) -> Void) {
        os_log("Started saving image in profile setting screen", log: logger, type: .default)
        guard let data = image.jpegData(compressionQuality: 0.0) else {
            return
        }
        let fileName = "\(UUID().uuidString).jpeg"
        worker.uploadFile(data, fileName, "image/jpeg") { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let fileMetaData):
                ImageCacheManager.shared.saveImage(image, for: fileMetaData.fileURL as NSURL)
                completion(.success(fileMetaData))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
