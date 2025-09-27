//
//  PersistenceController.swift
//  MetalHud
//

import SwiftUI

final class PersistenceController {
    private let fileName = "MetalHudState.txt"
    private var fileURL: URL {
        let fm = FileManager.default
        let appSupport = try! fm.url(for: .applicationSupportDirectory,
                                     in: .userDomainMask,
                                     appropriateFor: nil,
                                     create: true)
        let dir = appSupport.appendingPathComponent("MetalHud", isDirectory: true)
        if !fm.fileExists(atPath: dir.path) {
            try? fm.createDirectory(at: dir, withIntermediateDirectories: true, attributes: nil)
        }
        return dir.appendingPathComponent(fileName)
    }

    func save(enabled: Bool) {
        do {
            let s = enabled ? "1" : "0"
            try s.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Persistence save error:", error)
        }
    }

    func loadEnabled() -> Bool? {
        do {
            let s = try String(contentsOf: fileURL, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)
            return s == "1"
        } catch {
            return nil
        }
    }
}
