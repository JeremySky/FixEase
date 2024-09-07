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
    
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    
    var body: some View {
        ZStack {
            if let i = viewModel.getItemIndex() {
                ItemDetailView($viewModel.collection[i], $viewModel.selectedItemID, viewModel: viewModel)
                    .statusBar(hidden: true)
            } else {
                if viewModel.user != nil {
                    MainView(viewModel: viewModel)
                        .statusBar(hidden: true)
                } else {
                    WelcomeView() { name in
                        showTutorial = true
                        viewModel.createUser(name)
                    }
                    .statusBar(hidden: true)
                }
            }
        }
        .padding(isIpad ? .all : [])
        .background(getBackground())
        .onAppear {
            viewModel.getUpkeepsDueNow()
            NotificationManager.shared.removeDeliveredNotifications()
        }
        .fullScreenCover(isPresented: $showTutorial, content: {
            TutorialTabView() {
                showTutorial = false
            }
        })
        .statusBar(hidden: true)
    }
    
    private func getBackground() -> some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Ellipse()
                        .frame(width: isIpad ? 1550 : 550, height: 350)
                        .foregroundStyle(Gradient(colors: [Color.greenLight, Color.greenDark]))
                        .rotationEffect(isIpad ? .degrees(0) : .degrees(-7))
                }
                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .offset(y: isIpad ? -geometry.size.height/10 : -geometry.size.height/6.3)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    ContentView()
}

