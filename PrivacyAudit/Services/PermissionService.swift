//
//  PermissionService.swift
//  PrivacyAudit
//
//  Created by sideffect on 18.12.2025.
//

import Foundation
import AVFoundation
import Photos
import Contacts
import EventKit
import CoreLocation
import UserNotifications

class PermissionService {
    
    func checkPermission(for type: PermissionType) -> PermissionStatus {
            switch type {
            case .camera:
                return checkCamera()
            case .microphone:
                return checkMicrophone()
            case .photos:
                return checkPhotos()
            case .contacts:
                return checkContacts()
            case .calendar:
                return checkCalendar()
            case .location:
                return checkLocation()
            case .notifications:
                return .notDetermined
            }
    }
    
    private func checkCamera() -> PermissionStatus {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized: return .authorized
        case .denied: return .denied
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        @unknown default: return .notDetermined
        }
    }
    
    private func checkMicrophone() -> PermissionStatus {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        switch status {
        case .authorized: return .authorized
        case .denied: return .denied
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        @unknown default: return .notDetermined
        }
    }
    
    private func checkPhotos() -> PermissionStatus {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized, .limited: return .authorized
        case .denied: return .denied
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        @unknown default: return .notDetermined
        }
    }
    
    private func checkContacts() -> PermissionStatus {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized: return .authorized
        case .denied: return .denied
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        @unknown default: return .notDetermined
        }
    }
    
    private func checkCalendar() -> PermissionStatus {
        let status = EKEventStore.authorizationStatus(for: .event)
        switch status {
        case .authorized, .fullAccess, .writeOnly: return .authorized
        case .denied: return .denied
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        @unknown default: return .notDetermined
        }
    }
    
    private func checkLocation() -> PermissionStatus {
        let status = CLLocationManager().authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse: return .authorized
        case .denied: return .denied
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        @unknown default: return .notDetermined
        }
    }
    
    func requestPermission(for type: PermissionType, completion: @escaping (PermissionStatus) -> Void) {
        switch type {
        case .camera:
            requestCamera(completion: completion)
        case .microphone:
            requestMicrophone(completion: completion)
        case .photos:
            requestPhotos(completion: completion)
        case .contacts:
            requestContacts(completion: completion)
        case .calendar:
            requestCalendar(completion: completion)
        case .location:
            requestLocation(completion: completion)
        case .notifications:
            requestNotifications(completion: completion)
        }
    }

    private func requestCamera(completion: @escaping (PermissionStatus) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                completion(granted ? .authorized : .denied)
            }
        }
    }

    private func requestMicrophone(completion: @escaping (PermissionStatus) -> Void) {
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            DispatchQueue.main.async {
                completion(granted ? .authorized : .denied)
            }
        }
    }

    private func requestPhotos(completion: @escaping (PermissionStatus) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    completion(.authorized)
                default:
                    completion(.denied)
                }
            }
        }
    }

    private func requestContacts(completion: @escaping (PermissionStatus) -> Void) {
        CNContactStore().requestAccess(for: .contacts) { granted, _ in
            DispatchQueue.main.async {
                completion(granted ? .authorized : .denied)
            }
        }
    }

    private func requestCalendar(completion: @escaping (PermissionStatus) -> Void) {
        EKEventStore().requestFullAccessToEvents { granted, _ in
            DispatchQueue.main.async {
                completion(granted ? .authorized : .denied)
            }
        }
    }

    private func requestLocation(completion: @escaping (PermissionStatus) -> Void) {
        // Location için özel bir manager gerekiyor, şimdilik ayarlara yönlendirelim
        completion(.notDetermined)
    }

    private func requestNotifications(completion: @escaping (PermissionStatus) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            DispatchQueue.main.async {
                completion(granted ? .authorized : .denied)
            }
        }
    }
        
}

