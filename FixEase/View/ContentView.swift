//
//  ContentView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/16/24.
//
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var collection: [Item]
    @Published var selectedItemID: UUID?
    @Published var dueNow: [(upkeep: Upkeep, isCompleted: Bool)]
    
    init(collection: [Item], selectedItemID: UUID? = nil, dueNow: [(upkeep: Upkeep, isCompleted: Bool)] = []) {
        self.collection = collection
        self.selectedItemID = selectedItemID
        self.dueNow = dueNow
    }
    
    func moveUpkeepToBottomOfList(id: UUID) {
        if let i = self.dueNow.firstIndex(where: { $0.upkeep.id == id }) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    let element = self.dueNow.remove(at: i)
                    self.dueNow.append(element)
                }
            }
        }
    }
    
    func getUpkeepsDueNow() {
        func setEmoji(from item: Item, to upkeep: Upkeep) -> Upkeep {
            var updatedUpkeep = upkeep
            updatedUpkeep.emoji = item.emoji
            return updatedUpkeep
        }
        
        var list = [Upkeep]()
        for item in collection {
            for upkeep in item.upkeeps {
                if upkeep.dueDate <= Date.endOfDay {
                    list.append(setEmoji(from: item, to: upkeep))
                }
            }
        }
    
        self.dueNow = list.sorted(by: { $0.emoji! < $1.emoji! }).map({(upkeep: $0, isCompleted: false)})
    }
    func getItemIndex() -> Int? {
        self.collection.firstIndex(where: {$0.id == self.selectedItemID})
    }
}

struct ContentView: View {
    
    @StateObject var viewModel: MainViewModel = MainViewModel(collection: Item.list)
    
    var body: some View {
        ZStack {
            if let i = viewModel.getItemIndex() {
                ItemDetailView($viewModel.collection[i], $viewModel.selectedItemID)
            } else {
                MainView(viewModel: viewModel)
            }
        }
        .background(getBackground())
        .onAppear {
            viewModel.getUpkeepsDueNow()
        }
    }
    
    private func getBackground() -> some View {
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

