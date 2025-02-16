//
//  LocalizationManager.swift
//  chakchat
//
//  Created by лизо4ка курунок on 16.02.2025.
//

import Foundation

final class LocalizationManager: LocalizationManagerProtocol {
    static let shared = LocalizationManager()
    
    private var bundle: Bundle?

    private init() {
        loadLanguage()
    }

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

extension Notification.Name {
    static let languageDidChange = Notification.Name("languageDidChange")
}
