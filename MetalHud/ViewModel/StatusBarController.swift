//
//  StatusBarController.swift
//  MetalHud
//

import SwiftUI

final class StatusBarController: NSObject {
    private(set) var statusItem: NSStatusItem!
    weak var settingsWindow: NSWindow?
    private var toggleObserver: NSKeyValueObservation?

    func setupStatusBarMenu() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        var enable = MetalHudManager.shared.persistence.loadEnabled()
        
        if enable == nil{
            enable = true
            MetalHudManager.shared.persistence.save(enabled: enable!)
        }
        
        enable! ? MetalHudManager.shared.hudController.enable() : MetalHudManager.shared.hudController.disable()
        
        if let button = statusItem.button {
            button.title = "Metal Hud \(enable! ? "🟢" : "🔴")"
            button.action = #selector(statusBarClicked(_:))
            button.target = self
        }

        let menu = NSMenu()
        let openItem = NSMenuItem(title: "Settings", action: #selector(openSettings(_:)), keyEquivalent: "s")
        openItem.target = self
        menu.addItem(openItem)

        menu.addItem(NSMenuItem.separator())

        let quitItem = NSMenuItem(title: "Quit", action: #selector(quitApp(_:)), keyEquivalent: "q")
        quitItem.target = self
        menu.addItem(quitItem)

        statusItem.menu = menu

        NSApp.setActivationPolicy(.accessory)
    }

    @objc private func statusBarClicked(_ sender: Any?) {}

    @objc private func openSettings(_ sender: Any?) {
        if let win = settingsWindow {
            win.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            NSApp.setActivationPolicy(.regular)
            return
        }

        let contentView = MetalHudViewRepresentable()
        let hosting = NSHostingController(rootView: contentView)
        let window = NSWindow(contentViewController: hosting)
        window.styleMask = [.titled, .closable, .miniaturizable]
        window.title = "Metal Hud Settings"
        window.setContentSize(NSSize(width: 300, height: 120))
        window.center()
        window.isReleasedWhenClosed = false
        window.delegate = self

        settingsWindow = window
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        NSApp.setActivationPolicy(.regular)
    }

    @objc private func quitApp(_ sender: Any?) {
        NSApplication.shared.terminate(nil)
    }
}
