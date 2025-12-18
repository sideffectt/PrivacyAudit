//
//  SettingsViewModel.swift
//  PrivacyAudit
//
//  Created by sideffect on 18.12.2025.
//

import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    
    @AppStorage("appTheme") var appTheme: String = "system"
    
    var colorScheme: ColorScheme? {
        switch appTheme {
        case "light": return .light
        case "dark": return .dark
        default: return nil
        }
    }
}
