//
//  PermissionDetailView.swift
//  PrivacyAudit
//
//  Created by sideffect on 18.12.2025.
//

import SwiftUI

struct PermissionDetailView: View {
    @State var permission: Permission
    private let service = PermissionService()
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: permission.type.icon)
                .font(.system(size: 80))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .padding(.top, 40)
            
            Text(permission.type.rawValue)
                .font(.system(size: 32, weight: .bold, design: .rounded))
            
            Text(permission.type.description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            StatusBadge(status: permission.status)
            
            Spacer()
            
            VStack(spacing: 12) {
                if permission.status == .notDetermined {
                    Button(action: requestPermission) {
                        Text("Grant Permission")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                    }
                }
                
                Button(action: openSettings) {
                    Text("Open Settings")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }
    
    func requestPermission() {
        service.requestPermission(for: permission.type) { newStatus in
            permission.status = newStatus
        }
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}

struct StatusBadge: View {
    let status: PermissionStatus
    
    var body: some View {
        Text(status.rawValue)
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(colorForStatus)
            .cornerRadius(20)
    }
    
    var colorForStatus: Color {
        switch status {
        case .authorized: return .green
        case .denied: return .red
        case .notDetermined: return .orange
        case .restricted: return .gray
        }
    }
}
