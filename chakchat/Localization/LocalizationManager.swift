//
//  LocalizationManager.swift
//  chakchat
//
//  Created by лизо4ка курунок on 16.02.2025.
//

import Foundation

// MARK: - LocalizationManager
final class LocalizationManager: LocalizationManagerProtocol {
    
    // MARK: - Properties
    static let shared = LocalizationManager()
    private var bundle: Bundle?

    // MARK: - Initialization
    private init() {
        loadLanguage()
    }

    // MARK: - Public Methods
    func localizedString(for key: String) -> String {
        return bundle?.localizedString(forKey: key, value: nil, table: nil) ?? key
    }
    
    func setLanguage(_ languageCode: String, completion: @escaping () -> Void) {
        UserDefaults.standard.set(languageCode, forKey: "appLanguage")
        UserDefaults.standard.synchronize()
        
        loadLanguage()
        DispatchQueue.main.async {
            completion()
            NotificationCenter.default.post(name: .languageDidChange, object: nil)
        }
    }
    
    // MARK: - Private Methods
    private func loadLanguage() {
        let languageCode = UserDefaults.standard.string(forKey: "appLanguage") ?? Locale.current.languageCode ?? "en"
        
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            self.bundle = bundle
        } else {
            self.bundle = Bundle.main
        }
    }
}

// MARK: - Notification.Name
extension Notification.Name {
    static let languageDidChange = Notification.Name("languageDidChange")
}
