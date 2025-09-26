//
//  MetalHudApp.swift
//  MetalHudApp
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        let manager = MetalHudManager.shared
        manager.statusBarController.setupStatusBarMenu()
    }
}

@main
struct MetalHudApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            Text("MetalHud background")
                .frame(width: 0, height: 0)
        }
        .windowResizability(.contentSize)
    }
}
