//
//  HelpInteractor.swift
//  chakchat
//
//  Created by лизо4ка курунок on 23.02.2025.
//

import UIKit

// MARK: - HelpInteractor
final class HelpInteractor: HelpBusinessLogic {
    
    // MARK: - Properties
    private let presenter: HelpPresentationLogic
    var onRouteToSettingsMenu: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: HelpPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Send Mail about error
    func sendErrorMail(_ view: UIViewController) {
        MailHelper.shared.sendUserBugEmail(from: view)
    }
    
    // MARK: - Send Empty Mail
    func sendEmptyMail(_ view: UIViewController) {
        MailHelper.shared.sendEmptyEmail(from: view)
    }
    
    // MARK: - Open AppStore to review
    func reviewInAppStore() {
        // TODO: add appID
        let appID = "698255242"
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appID)?action=write-review"),
              UIApplication.shared.canOpenURL(url) else {
            print("Can't open App Store.")
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    // MARK: - Routing
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
}
