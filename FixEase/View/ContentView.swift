//
//  ContentView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/16/24.
//

import SwiftUI

enum ViewSelection {
    case main, itemDetail(Item)
}

class ViewManager: ObservableObject {
    @Published var current: ViewSelection
    
    init(current: ViewSelection = .main) {
        self.current = current
    }
}

struct ContentView: View {
    @StateObject var viewSelection = ViewManager()
    
    var body: some View {
        ZStack {
            switch viewSelection.current {
            case .main:
                MainView(Item.list)
            case .itemDetail(let item):
                ItemDetailView(item)
            }
        }
        .background(Background())
        .environmentObject(viewSelection)
    }
}

extension ContentView {
    struct Background: View {
        var body: some View {
            GeometryReader { geometry in
                VStack {
                    Ellipse()
                        .frame(width: 550, height: 350)
                        .foregroundStyle(Gradient(colors: [Color.greenLight, Color.greenDark]))
                        .rotationEffect(.degrees(-7))
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(y: -geometry.size.height/6.5)
            }
        }
    }
}

#Preview {
    ContentView()
}

