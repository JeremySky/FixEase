//
//  ContentView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/16/24.
//
import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: MainViewModel = MainViewModel(collection: [])
    @State var showTutorial: Bool = false
    
    var body: some View {
        ZStack {
            if let i = viewModel.getItemIndex() {
                ItemDetailView($viewModel.collection[i], $viewModel.selectedItemID)
            } else {
                if !viewModel.name.isEmpty {
                    MainView(viewModel: viewModel)
                } else {
                    WelcomeView() { name in
                        showTutorial = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { viewModel.name = name })
                    }
                }
            }
        }
        .background(getBackground())
        .onAppear {
            viewModel.getUpkeepsDueNow()
        }
        .fullScreenCover(isPresented: $showTutorial, content: {
            TutorialTabView() {
                showTutorial = false
            }
        })
    }
    
    private func getBackground() -> some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Ellipse()
                        .frame(width: 550, height: 350)
                        .foregroundStyle(Gradient(colors: [Color.greenLight, Color.greenDark]))
                        .rotationEffect(.degrees(-7))
                }
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

