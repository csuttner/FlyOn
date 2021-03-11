//
//  UUIDExtensions.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import Foundation

extension UUID {
    static func shortString() -> String {
        return String(self.init().uuidString.dropLast(self.init().uuidString.count - 8))
    }
}
