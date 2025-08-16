//
//  WhishlistApp.swift
//  Whishlist
//
//  Created by Josue Lubaki on 2025-08-16.
//

import SwiftUI
import SwiftData

@main
struct WhishlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Wish.self)
        }
    }
}
