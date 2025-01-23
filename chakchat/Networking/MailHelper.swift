//
//  MailHelper.swift
//  chakchat
//
//  Created by лизо4ка курунок on 23.01.2025.
//

import UIKit
import MessageUI

// MARK: - Mail Helper
class MailHelper: NSObject, MFMailComposeViewControllerDelegate {

    static let shared = MailHelper()
    
    // MARK: - Constants
    private enum Constants {
        static let recipient: String = "chakkchatt@yandex.ru"
        static let subject: String = "Error information"
        static let errorDuringSendingMessage: String = "The mail application is not configured. You can send us a message with information about the error to chakkhatt@yandex."
        static let errorButtonText: String = "OK"
        static let errorAlertTitle: String = "Error"

    }

    // MARK: - Initialization
    private override init() {}

    // MARK: - Send Error Email Method
    func sendEmail(message: String?, from viewController: UIViewController) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients([Constants.recipient])
            mailComposer.setSubject(Constants.subject)
            mailComposer.setMessageBody(configureMessage(errorMessage: message), isHTML: false)

            viewController.present(mailComposer, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: Constants.errorAlertTitle, message: Constants.errorDuringSendingMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.errorButtonText, style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func configureMessage(errorMessage: String?) -> String {
        var text = "Error text: \(errorMessage ?? "Error")\n"
        
        // Get app version and build number.
        if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
           let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
            text += "App version: \(appVersion)\n"
            text += "Build number: \(buildNumber)\n"
        } else {
            text += "Failed to get App version and Build number\n"
        }
        
        // Get iOS version.
        let iOSVersion = UIDevice.current.systemVersion
        text += "iOS version: \(iOSVersion)\n"
    
        // Get current date.
        let currentDate = Date()
        text += ("Current date: \(currentDate)\n")
        
        // Get battery charge level.
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = UIDevice.current.batteryLevel
        if batteryLevel >= 0 {
            let batteryPercentage = Int(batteryLevel * 100)
            text += "Battery charge level: \(batteryPercentage)%\n"
        } else {
            text += "Failed to get Battery charge level"
        }

        // Get info about whether the power saving mode is enabled.
        let isLowPowerModeEnabled = ProcessInfo.processInfo.isLowPowerModeEnabled
        text += "Low Power Mode: \(isLowPowerModeEnabled ? "On" : "Off")\n"

        return text
    }

    // MARK: - Mail Compose Controller
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)

        switch result {
        case .cancelled:
            print("Cancelled email sending.")
        case .saved:
            print("Saved email")
        case .sent:
            print("Email was sent.")
        case .failed:
            print("Error during email sending: \(String(describing: error))")
        @unknown default:
            break
        }
    }
}
