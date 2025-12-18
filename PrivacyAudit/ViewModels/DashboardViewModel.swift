//
//  DashboardViewModel.swift
//  PrivacyAudit
//
//  Created by sideffect on 18.12.2025.
//

import SwiftUI
import Combine


class DashboardViewModel: ObservableObject {
    
    @Published var permissions: [Permission] = []
    
    private let service = PermissionService()
    
    init() {
        loadPermissions()
    }
    
    func loadPermissions() {
        permissions = PermissionType.allCases.map { type in
            Permission(
                type: type,
                status: service.checkPermission(for: type)
            )
        }
    }
    
    var privacyScore: Int {
        guard !permissions.isEmpty else { return 0 }
        
        var score = 0
        for permission in permissions {
            switch permission.status {
            case .denied, .restricted:
                score += 100
            case .notDetermined:
                score += 50
            case .authorized:
                score += 0
            }
        }
        return score / permissions.count
    }
}
