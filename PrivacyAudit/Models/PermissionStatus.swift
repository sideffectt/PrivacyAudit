//
//  PermissionStatus.swift
//  PrivacyAudit
//
//  Created by sideffect on 18.12.2025.
//

import Foundation

enum PermissionStatus: String {
    case authorized = "Authorized"
    case denied = "Denied"
    case notDetermined = "Not Asked"
    case restricted = "Restricted"
    
    var color: String {
        switch self {
        case .authorized: return "green"
        case .denied: return "red"
        case .notDetermined: return "orange"
        case .restricted: return "gray"
        }
    }
}
