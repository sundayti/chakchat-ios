//
//  ThemeManager.swift
//  chakchat
//
//  Created by лизо4ка курунок on 22.02.2025.
//

import UIKit

// MARK: - ThemeManager
final class ThemeManager: ThemeManagerProtocols {
    
    static let shared = ThemeManager()
    private let themeKey = "selectedTheme"
    
    var currentTheme: AppTheme {
        get {
            if let savedTheme = UserDefaults.standard.string(forKey: themeKey),
               let theme = AppTheme(rawValue: savedTheme) {
                return theme
            }
            return .system
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: themeKey)
            applyTheme(theme: newValue)
        }
    }
    
    func applyTheme(theme: AppTheme) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return }
        
        switch theme {
        case .system:
            window.overrideUserInterfaceStyle = .unspecified
        case .light:
            window.overrideUserInterfaceStyle = .light
        case .dark:
            window.overrideUserInterfaceStyle = .dark
        }
    }
    
    private init() {}
}
