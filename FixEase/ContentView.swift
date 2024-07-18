//
//  ContentView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/16/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                MainView()
            }
        }
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
                .offset(y: -geometry.size.height/4.5)
            }
        }
    }
}

#Preview {
    ContentView()
}

