//
//  MetalHudView.swift
//  MetalHud
//
import SwiftUI

struct MetalHudViewRepresentable: View {
    @State private var enabled: Bool = MetalHudManager.shared.persistence.loadEnabled() ?? true

    var body: some View {
        VStack(spacing: 10) {
            Toggle("Enable Metal Hud", isOn: $enabled)
                .onChange(of: enabled) { _, newValue in
                    MetalHudManager.shared.persistence.save(enabled: newValue)
                    if newValue {
                        MetalHudManager.shared.hudController.enable()
                    } else {
                        MetalHudManager.shared.hudController.disable()
                    }

                    if let button = MetalHudManager.shared.statusBarController.statusItem.button {
                        button.title = "Metal Hud \(newValue ? "🟢" : "🔴")"
                    }
                }
                .toggleStyle(.switch)
                .padding(.horizontal, 10)
                

            Text("Restart the game to see the Metal HUD.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(width: 300, height: 100)
        .onAppear {
            if let button = MetalHudManager.shared.statusBarController.statusItem.button {
                button.title = "Metal Hud \(enabled ? "🟢" : "🔴")"
            }
        }
    }
}

#Preview {
    MetalHudViewRepresentable()
}
