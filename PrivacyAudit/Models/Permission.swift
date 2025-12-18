//
//  Permission.swift
//  PrivacyAudit
//
//  Created by sideffect on 18.12.2025.
//

import Foundation

struct Permission: Identifiable {
    let id = UUID()
    let type: PermissionType
    var status: PermissionStatus
}
