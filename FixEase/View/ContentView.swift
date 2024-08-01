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
                let index = collectionManager.collection.firstIndex(where: { $0.id == item.id })!
                ItemDetailView($collectionManager.collection[index])
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

