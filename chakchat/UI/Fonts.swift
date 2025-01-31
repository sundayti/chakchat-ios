//
//  Fonts.swift
//  chakchat
//
//  Created by лизо4ка курунок on 31.01.2025.
//

import UIKit

// MARK: - Fonts
enum Fonts {
    // Used: Enter text in button on SendCodeVC
    static let inputButton: UIFont = UIFont.systemFont(ofSize: 30, weight: .bold)
    // Used: Big label on VerifyVC
    static let inputHintLabel: UIFont = UIFont.systemFont(ofSize: 30, weight: .bold)
    // Used: Resend text in button on VerifyVC
    static let resendButton: UIFont = UIFont.systemFont(ofSize: 25, weight: .bold)
    // Used: Name and username text in SignupVC
    static let name: UIFont = UIFont.loadCustomFont(name: "Inter-Regular", size: 20)
    // Used: Create account text in button on SignupVC
    static let createButton: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold)
    // Used: Big ChakChat label in StartVC
    static let chakchat: UIFont = UIFont.loadCustomFont(name: "RammettoOne-Regular", size: 100)
    // Used: Tap label text in StartVC
    static let tap: UIFont = UIFont.loadCustomFont(name: "Montserrat-Bold", size: 25)
    // Used: ChatsVc, SettingsVC, NotificationsVC ...... as a header
    static let header: UIFont = UIFont.systemFont(ofSize: 24, weight: .bold)
}
