//
//  MainView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/17/24.
//

import SwiftUI

struct MainView: View {
    
    @Binding var collection: [Item]
    let selectItem: (Item) -> Void
    
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
                    ForEach(collection) { item in
                        Button { selectItem(item) } label: {
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
                Text("\(numCompleted)/\(upkeeps.count) Complete")
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)
            
            //list...
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(upkeeps) { upkeep in
                        UpkeepRow(upkeep) {
                            numCompleted += 1
                        }
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $newItemIsPresented, content: {
            ModifyItemView(submit: { collection.append($0) })
        })
    }
}

#Preview {
    ContentView()
}
