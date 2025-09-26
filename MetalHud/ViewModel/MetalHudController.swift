//
//  MetalHudController.swift

import Foundation
import UserNotifications

final class MetalHudController {
    func enable() {
        setEnv(key: "1")
    }

    func disable() {
        setEnv(key: "0")
    }

    private func setEnv(key: String) {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/launchctl")
        process.arguments = ["setenv", "MTL_HUD_ENABLED", key]

        do {
            try process.run()
            process.waitUntilExit()
            if process.terminationStatus == 0 {
                Swift.print("launchctl: setenv MTL_HUD_ENABLED = \(key)")
            } else {
                Swift.print("launchctl exit code: \(process.terminationStatus)")
            }
        } catch {
            Swift.print("Failed to run launchctl:", error)
        }
    }
}
