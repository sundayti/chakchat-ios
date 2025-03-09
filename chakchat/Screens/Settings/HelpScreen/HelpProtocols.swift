//
//  HelpProtocols.swift
//  chakchat
//
//  Created by лизо4ка курунок on 23.02.2025.
//

import UIKit

// MARK: - HelpProtocols
protocol HelpBusinessLogic {
    func backToSettingsMenu()
    func sendErrorMail(_ view: UIViewController)
    func sendEmptyMail(_ view: UIViewController)
    func reviewInAppStore()
}

protocol HelpPresentationLogic {
}
