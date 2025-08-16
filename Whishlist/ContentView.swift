//
//  ContentView.swift
//  Whishlist
//
//  Created by Josue Lubaki on 2025-08-16.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wishes: [Wish]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishes) { wish in
                    Text(wish.title)
                }
            }//: LIST
            .navigationTitle("WishList")
            .overlay {
                if wishes.isEmpty {
                    ContentUnavailableView(
                        "My Wishlist",
                        systemImage: "heart.circle",
                        description: Text("No wishes yet. Add one to get started!")
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
