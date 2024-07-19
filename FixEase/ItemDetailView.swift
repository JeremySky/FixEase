//
//  ItemDetailView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/18/24.
//

import SwiftUI

struct ItemDetailView: View {
    
    @State var item: Item
    
    init(_ item: Item) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            
            //MARK: -- Item Details...
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(LinearGradient(colors: [.white, .clear], startPoint: .center, endPoint: .trailing))
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(item.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.greenDark)
                        Text(item.description)
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .padding(.bottom, 5)
                        Text("\(item.upkeeps.count) Upkeeps")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .fontWidth(.compressed)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    Text(item.emoji)
                        .font(.custom("Item Emoji", fixedSize: 80))
                        .padding(.trailing)
                }
                .padding(.bottom, 5)
            }
            .frame(height: 120)
            .padding()
            
            Spacer().frame(height: 70)
            
            UpkeepsDetailView($item.upkeeps)
        }
        
        
        
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    //BACK
                },
                       label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.caption)
                        Text("Back")
                    }
                })
                .foregroundStyle(.white)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Upkeep") {
                    //ADD UPKEEP
                }
                .foregroundStyle(.white)
            }
        }
    }
}


extension ItemDetailView {
    struct UpkeepsDetailView: View {
        
        @Binding var upkeeps: [Upkeep]
        @State var index: Int = 0
        
        init(_ upkeeps: Binding<[Upkeep]>, index: Int = 0) {
            self._upkeeps = upkeeps
            self.index = index
        }
        
        var body: some View {
            //WIP empty view
            HStack {
                Button(action: {
                    if index > 0 {
                        index -= 1
                    }
                },
                       label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.gray)
                })
                .disabled(index == 0)
                //MARK: -- Upkeep Details...
                VStack {
                    Text(upkeeps[index].description)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.greenDark)
                    Text("Every 2 Years")
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                    Text("Saturday July 11, 2024")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity)
                Button(action: {
                    if index < upkeeps.count {
                        index += 1
                    }
                },
                       label: {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.gray)
                })
                .disabled(index == (upkeeps.count - 1))
            }
            .padding()
            
            
            //MARK: -- Notes...
            VStack(alignment: .leading) {
                Text("Notes:")
                    .bold()
                    .padding(.horizontal)
                List {
                    ForEach(1..<4) { note in
                        Text("This is a very important note.")
                    }
                    Button("+ New Note") {
                        print("Click click click")
                    }
                    .foregroundStyle(Color.greenDark)
                }
                .listStyle(.inset)
                .scrollIndicators(.hidden)
            }
            .padding()
        }
    }
}





#Preview {
    NavigationStack {
        ZStack {
            ContentView.Background()
            ItemDetailView(Item.exRocketShip)
        }
    }
}
