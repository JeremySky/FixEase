//
//  ItemDetailView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/18/24.
//

import SwiftUI

struct ItemDetailView: View {
    
    @EnvironmentObject var viewManager: ViewManager
    @Binding var item: Item
    @State var upkeepIndex: Int
    @State var modifyNote: (string: String, isNew: Bool, index: Int?)?
    
    init(_ item: Binding<Item>, upkeepIndex: Int = 0) {
        self._item = item
        self._upkeepIndex = State(initialValue: upkeepIndex)
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button("Back") {
                        viewManager.current = .main
                    }
                    Spacer()
                    Button("New Upkeep") {
                        viewManager.sheet = .modifyUpkeep(Upkeep(), item.id)
                    }
                }
                .padding(.horizontal)
                .foregroundStyle(.white)
                
                //MARK: -- Item Details...
                Button(action: { viewManager.sheet = .modifyItem(item) }) {
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(item.name)
                                .font(.title2.weight(.heavy))
                                .foregroundStyle(Color.greenDark)
                            Text(item.description)
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .padding(.bottom, 10)
                            Text("\(item.upkeeps.count) Upkeeps")
                                .font(.largeTitle.weight(.black).width(.compressed))
                                .foregroundStyle(Color.black.opacity(0.8))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                        Text(item.emoji)
                            .font(.custom("Item Emoji", fixedSize: 80))
                            .padding(.trailing)
                    }
                    .padding(.top, 2)
                    .padding(.bottom, 4)
                    .background(
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(LinearGradient(colors: [.white, .clear], startPoint: .center, endPoint: .trailing))
                            Spacer().frame(width: 5)
                        }
                            .shadow(radius: 10, x: -5, y: 5)
                    )
                }
                .padding()
                
                Spacer().frame(height: 60)
                
                ZStack {
                    UpkeepDetailView(forUpkeepIn: item, at: upkeepIndex)
                    UpkeepIndexStepper($upkeepIndex, for: item)
                }
            }
        }
    }
}



#Preview {
    ContentView(viewManager: ViewManager(current: .itemDetail(Item.exRocketShip)))
        .background(ContentView.Background())
}
