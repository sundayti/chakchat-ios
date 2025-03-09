//
//  ErrorId.swift
//  chakchat
//
//  Created by Елизавета Хромова on 17.01.2025.
//

// MARK: - ErrorId
struct ErrorId {
    var message: String?
    var type: ErrorOutput
}

enum ErrorOutput {
    case Alert
    case DisappearingLabel
    case None
}
