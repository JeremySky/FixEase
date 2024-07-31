//
//  ContentView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/16/24.
//
import SwiftUI

struct ContentView: View {
    @StateObject var collectionManager = CollectionManager(collection: Item.list)
    
    var body: some View {
        ZStack {
            if let item = collectionManager.selectedItem?.value {
                ItemDetailView($collectionManager.collection.first(where: { $0.wrappedValue.id == item.id })!)
            } else {
                MainView()
            }
        }
        .environmentObject(collectionManager)
        .background(Background().ignoresSafeArea(.keyboard))
    }
}

#Preview {
    ContentView()
}

