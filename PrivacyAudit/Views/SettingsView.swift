//
//  SettingsView.swift
//  PrivacyAudit
//
//  Created by sideffect on 18.12.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section("Appearance") {
                    Picker("Theme", selection: $viewModel.appTheme) {
                        Text("System").tag("system")
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Developer")
                        Spacer()
                        Text("sideffectt")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section("Privacy") {
                    Link(destination: URL(string: "https://apple.com/privacy")!) {
                        HStack {
                            Text("Privacy Policy")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section("Support") {
                    Link(destination: URL(string: "mailto:your@email.com")!) {
                        HStack {
                            Text("Contact Us")
                            Spacer()
                            Image(systemName: "envelope")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Button(action: rateApp) {
                        HStack {
                            Text("Rate App")
                            Spacer()
                            Image(systemName: "star")
                                .foregroundColor(.secondary)
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    func rateApp() {
        // App Store ID  
    }
}
