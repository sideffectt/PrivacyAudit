import Foundation

enum PermissionType: String, CaseIterable {
    case camera = "Camera"
    case microphone = "Microphone"
    case location = "Location"
    case photos = "Photos"
    case contacts = "Contacts"
    case calendar = "Calendar"
    case notifications = "Notifications"
    
    var icon: String {
        switch self {
        case .camera: return "camera.fill"
        case .microphone: return "mic.fill"
        case .location: return "location.fill"
        case .photos: return "photo.fill"
        case .contacts: return "person.crop.circle.fill"
        case .calendar: return "calendar"
        case .notifications: return "bell.fill"
        }
    }
    
    var description: String {
        switch self {
        case .camera: return "Apps that can access your camera"
        case .microphone: return "Apps that can record audio"
        case .location: return "Apps that can track your location"
        case .photos: return "Apps that can view your photos"
        case .contacts: return "Apps that can read your contacts"
        case .calendar: return "Apps that can access your calendar"
        case .notifications: return "Apps that can send you notifications"
        }
    }
}
