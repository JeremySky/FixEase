//
//  ContentView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/16/24.
//
import SwiftUI

struct ContentView: View {
    
    @State var collection = Item.list
    @State var selectedItemID: UUID?
    
    var body: some View {
        ZStack {
            if let i = collection.firstIndex(where: {$0.id == selectedItemID}) {
                ItemDetailView($collection[i], $selectedItemID)
            } else {
                MainView($collection) { selectItem($0) }
            }
        }
        .background(getBackground())
    }
    
    
    func selectItem(_ item: Item) {
        self.selectedItemID = item.id
    }
    func getBackground() -> some View {
        GeometryReader { geometry in
            VStack {
                Ellipse()
                    .frame(width: 550, height: 350)
                    .foregroundStyle(Gradient(colors: [Color.greenLight, Color.greenDark]))
                    .rotationEffect(.degrees(-7))
                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .offset(y: -geometry.size.height/6.3)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    ContentView()
}

