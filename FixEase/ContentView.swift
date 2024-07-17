//
//  ContentView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/16/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Background()
            
        }
    }
}

extension ContentView {
    struct Background: View {
        var body: some View {
            VStack {
                Ellipse()
                    .frame(width: 550, height: 350)
                    .foregroundStyle(Gradient(colors: [Color.greenLight, Color.greenDark]))
                    .rotationEffect(.degrees(-7))
                    .ignoresSafeArea()
                    .offset(y: -130)
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

