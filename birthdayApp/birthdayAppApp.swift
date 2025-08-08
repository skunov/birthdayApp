//
//  birthdayAppApp.swift
//  birthdayApp
//
//  Created by Scholar on 8/8/25.
//

import SwiftUI
import SwiftData

@main
struct birthdayAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
