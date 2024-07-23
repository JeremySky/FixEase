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
    @Published var modifyItemIsPresenting: Bool
    
    init(current: ViewSelection = .main, modifyItemIsPresenting: Bool = false) {
        self.current = current
        self.modifyItemIsPresenting = modifyItemIsPresenting
    }
}

struct ContentView: View {
    @StateObject var viewManager = ViewManager()
    
    var body: some View {
        ZStack {
            switch viewManager.current {
            case .main:
                MainView(Item.list)
            case .itemDetail(let item):
                ItemDetailView(item)
            }
        }
        .background(Background())
        .environmentObject(viewManager)
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
                .offset(y: -geometry.size.height/6.3)
            }
        }
    }
}

#Preview {
    ContentView()
}
