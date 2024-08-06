//
//  MainView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/17/24.
//

import SwiftUI


struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @State var newItemIsPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Spacer()
                Button("New Item") { newItemIsPresented = true }
            }
            .foregroundStyle(.white)
            .padding(.horizontal)
            
            
            //MARK: -- Welcome message...
            VStack(alignment: .leading) {
                Text("Hello, John")
                    .font(.title.weight(.bold))
                Text("Keep your valuables in prime condition.")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.white)
            .padding(.top, 8)
            .padding(.horizontal)
            
            
            
            //MARK: -- Items List View...
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 17) {
                    ForEach(viewModel.collection) { item in
                        Button { viewModel.selectedItemID = item.id } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 78)
                                    .foregroundStyle(Color.white)
                                    .shadow(radius: 10)
                                Text(item.emoji)
                                    .font(.custom("Item Button", fixedSize: 45))
                            }
                        }
                    }
                }
                .padding()
            }
            
            
            
            //MARK: -- Upkeeps List...
            HStack {
                Text("Upkeeps")
                    .font(.largeTitle.weight(.heavy))
                    .foregroundStyle(Color.greenLight)
                Spacer()
            }
            .padding(.horizontal)
            
            //list...
            ScrollView {
                VStack(spacing: 30) {
                    ForEach($viewModel.dueNow, id: \.self.upkeep.id) { $value in
                        UpkeepRow(value.upkeep, isCompleted: $value.isCompleted) {
//                            update collection[i].upkeeps[j].dueDate
                            let cycle = value.upkeep.cycle
                            let rule = cycle.rule
                            let unit = cycle.unit
                            var components = DateComponents()
                            
                            switch rule {
                            case .days:
                                components.day = unit
                            case .weeks:
                                components.day = (unit * 7)
                            case .months:
                                components.month = unit
                            case .years:
                                components.year = unit
                            }
                            
                            let refreshedDate = Calendar.current.date(byAdding: components, to: Date())!
                            let i = viewModel.collection.firstIndex(where: { $0.id == value.upkeep.itemID })!
                            let j = viewModel.collection[i].upkeeps.firstIndex(where: { $0.id == value.upkeep.id })!
                            
                            viewModel.collection[i].upkeeps[j].dueDate = refreshedDate
//                            remove or move to bottom of viewModel.dueNow
                            viewModel.moveUpkeepToBottomOfList(id: value.upkeep.id)
                        }
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $newItemIsPresented, content: {
            ModifyItemView(submit: { viewModel.collection.append($0) })
        })
    }
}

#Preview {
    ContentView()
}
