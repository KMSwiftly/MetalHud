//
//  StatusBar.swift
//  MetalHud
//

import SwiftUI
import AppKit

extension StatusBarController: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        if let win = settingsWindow {
            win.orderOut(nil) // hide
        }
        NSApp.setActivationPolicy(.accessory)
    }
}
