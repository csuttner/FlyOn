//
//  UUIDExtensions.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/14/21.
//

import Foundation

extension UUID {
    static func shortString() -> String {
        return String(self.init().uuidString.prefix(8))
    }
}
