//
//  Errors.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import Foundation

enum ServerError: Error {
    case postError
    case putError
    case deleteError
    case readError
}

enum ValidationError: Error {
    case missingData
    case passwordMismatch
    case passwordWeak
    case roleNotFound
}

extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("All fields are required", comment: "")
        case .passwordMismatch:
            return NSLocalizedString("Passwords must match", comment: "")
        case .passwordWeak:
            return NSLocalizedString("Passwords must be at least 8 characters long and contain at least one number, uppercase, and lowercase letter", comment: "")
        case .roleNotFound:
            return NSLocalizedString("Role must be one of the following: technician, analyst", comment: "")
        }
    }
}
