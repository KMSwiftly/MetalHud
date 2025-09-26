//
//  MetalHudManager.swift
//  MetalHud
//

final class MetalHudManager {
    static let shared = MetalHudManager()

    let statusBarController = StatusBarController()
    let hudController = MetalHudController()
    let persistence = PersistenceController()

    private init() {}
}
