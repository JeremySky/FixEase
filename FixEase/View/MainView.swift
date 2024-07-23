//
//  MainView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/17/24.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewSelection: ViewManager
    @State var collection: [Item]
    @State var numCompleted: Int = 0
    
    var upkeeps: [Upkeep] {
        var list = [Upkeep]()
        for item in collection {
            for upkeep in item.upkeeps {
                var updatedUpkeep = upkeep
                updatedUpkeep.emoji = item.emoji
                list.append(updatedUpkeep)
            }
        }
        list.sort { x, y in
            x.dueDate < y.dueDate
        }
        return list
    }
    
    init(_ collection: [Item]) {
        self.collection = collection
    }
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Spacer()
                Button("New Item") {
                    // Modify Item
                }
            }
            .foregroundStyle(.white)
            .padding(.horizontal)
            
            
            //MARK: -- Welcome message...
            VStack(alignment: .leading) {
                Text("Hello, John")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Keep your valuables in prime condition.")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.white)
            .padding(.top, 8)
            .padding(.horizontal)
            
            
            
            //MARK: -- Items List View...
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 17) {
                    ForEach(collection, id: \.self) { item in
                        Button {
                            viewSelection.current = .itemDetail(item)
                        } label: {
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
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.greenLight)
                Spacer()
                Text("\(numCompleted)/\(upkeeps.count) Complete")
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)
            
            //list...
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(upkeeps, id: \.self) { upkeep in
                        UpkeepRowView(upkeep) {
                            numCompleted += 1
                        }
                    }
                }
                .padding()
            }
            
            
            
        }
        .toolbar {
            Button("Add Item") {
                //ADD ITEM
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    MainView(Item.list)
        .background(ContentView.Background())
        .environmentObject(ViewManager())
}
