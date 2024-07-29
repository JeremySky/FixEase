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
    
    
    
    var leftButtonIsDisabled: Bool { upkeepIndex <= 0 }
    var rightButtonIsDisabled: Bool { upkeepIndex >= item.upkeeps.count - 1 }
    
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
                        viewManager.sheet = .newUpkeep
                    }
                }
                .padding(.horizontal)
                .foregroundStyle(.white)
                
                //MARK: -- Item Details...
                Button(action: { viewManager.sheet = .updateItem(item) }) {
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
                
                Spacer().frame(height: 40)
                
                
                //MARK: -- UpkeepDetailView...
                //WIP empty view
                if item.upkeeps.isEmpty {
                    VStack {
                        Text("EMPTY")
                        Spacer()
                    }
                } else {
                    HStack {
                        Button(action: {
                            if !leftButtonIsDisabled {
                                upkeepIndex -= 1
                            }
                        },
                               label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color.gray)
                                .opacity(leftButtonIsDisabled ? 0.3 : 1)
                        })
                        .disabled(leftButtonIsDisabled)
                        
                        
                        //MARK: -- Upkeep Details...
                        Button(action: { viewManager.sheet = .updateUpkeep(item.upkeeps[upkeepIndex]) }) {
                            VStack {
                                Text(item.upkeeps[upkeepIndex].description)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.greenDark)
                                Text("Every 2 Years")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.gray)
                                Text("\(item.upkeeps[upkeepIndex].dueDate, format: .dateTime.weekday(.wide)) \(item.upkeeps[upkeepIndex].dueDate, format: .dateTime.day().month().year())")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        
                        
                        Button(action: {
                            if !rightButtonIsDisabled {
                                upkeepIndex += 1
                            }
                        },
                               label: {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.gray)
                                .opacity(rightButtonIsDisabled ? 0.3 : 1)
                        })
                        .disabled(rightButtonIsDisabled)
                    }
                    .padding()
                    
                    
                    //MARK: -- Notes...
                    VStack(alignment: .leading) {
                        Text("Notes:")
                            .bold()
                            .padding(.horizontal)
                        List {
                            ForEach(Array(item.upkeeps[upkeepIndex].notes.enumerated()), id: \.element) { index, note in
                                Button(note) {
                                    viewManager.modifyNote = note
                                }
                                .foregroundStyle(.primary)
                                .buttonStyle(.borderless)
                            }
                            Button("+ New Note") {
                                viewManager.modifyNote = ""
                            }
                            .foregroundStyle(Color.greenDark)
                            .buttonStyle(.borderless)
                        }
                        .listStyle(.inset)
                        .scrollIndicators(.hidden)
                    }
                    .padding()
                }
            }
        }
    }
}





#Preview {
    ContentView(viewManager: ViewManager(current: .itemDetail(Item.exRocketShip)))
        .background(ContentView.Background())
}
