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
    
    @State private var isAlertShowing : Bool = false
    @State private var title : String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishes) { wish in
                    Text(wish.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(wish)
                            }
                        }
                }
            }//: LIST
            .navigationTitle("WishList")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        isAlertShowing.toggle()
                    } label : {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
                
                if !wishes.isEmpty {
                    ToolbarItem(placement: .bottomBar){
                        Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : "")")
                    }
                }
            }
            .alert("Create a new Wish", isPresented: $isAlertShowing){
                TextField("Enter a wish", text : $title)
                
                Button {
                    if title.isEmpty { return }
                    else {
                        let newWish = Wish(title: title)
                        modelContext.insert(newWish)
                        title = ""
                    }
                } label : {
                    Text("Save")
                }
            }
            .overlay {
                if wishes.isEmpty {
                    ContentUnavailableView(
                        "My Wishlist",
                        systemImage: "heart.circle",
                        description: Text("No wishes yet. Add one to get started!")
                    )
                }
            }
        } //: NAVIGATION STACK
    }
}

#Preview("List with Sample Data") {
    let container = try! ModelContainer(for : Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    container.mainContext.insert(Wish(title: "New MacBook Pro"))
    container.mainContext.insert(Wish(title: "iPhone 15 Pro"))
    container.mainContext.insert(Wish(title: "AirPods Pro"))
    container.mainContext.insert(Wish(title: "Apple Watch Series 9"))
    container.mainContext.insert(Wish(title: "iPad Pro"))
    container.mainContext.insert(Wish(title: "HomePod"))
    
    return ContentView()
        .modelContainer(container)
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
