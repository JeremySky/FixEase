//
//  TutorialTabView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 8/7/24.
//

import SwiftUI

struct TutorialTabView: View {
    
    let action: () -> Void
    
    let upkeep = Upkeep(id: UUID(), description: "Add Rocket Fuel", dueDate: Date(), cycle: Upkeep.Cycle(rule: .months, unit: 6), itemID: UUID(), emoji: "🚀", notes: [Note("Only use S+ tier fuel!")])
    @State var isCompleted: Bool = false
    @State var showEndTutorial: Bool = false
    
    var body: some View {
        ZStack {
            Color.greenDark.ignoresSafeArea()
            VStack {
                Button("Skip") { action() }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                Spacer()
                TabView {
                    // Add Item to Collection...
                    Section {
                        HStack(spacing: 20) {
                            ZStack {
                                Circle()
                                    .frame(width: 78)
                                    .foregroundStyle(Color.white)
                                    .shadow(radius: 10)
                                Text("+")
                                    .font(.largeTitle.weight(.black))
                                    .foregroundStyle(.greenDark)
                            }
                            Group {
                                VStack(alignment: .leading) {
                                    Text("Start by adding a new ") +
                                    Text("ITEM").fontWeight(.black)
                                    Text("to your ") +
                                    Text("Collection").fontWeight(.black)
                                }
                            }
                            .foregroundStyle(.white)
                            Spacer()
                        }
                        .padding()
                        
                    }
                    
                    // Add Upkeeps to Item...
                    Section {
                        VStack {
                            HStack(spacing: 20) {
                                ZStack {
                                    Circle()
                                        .frame(width: 78)
                                        .foregroundStyle(Color.white)
                                        .shadow(radius: 10)
                                    Text(upkeep.emoji!)
                                        .font(.custom("Item Button", fixedSize: 45))
                                }
                                Group {
                                    VStack(alignment: .leading) {
                                        Text("Select an ") +
                                        Text("ITEM ").fontWeight(.black) +
                                        Text("you've created")
                                        Text("and add a new ") +
                                        Text("UPKEEP").fontWeight(.black)
                                    }
                                }
                                .foregroundStyle(.white)
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    
                    // Completing Tasks...
                    Section {
                        VStack {
                            Group {
                                if !isCompleted {
                                    Text("On the ") +
                                    Text("HOME SCREEN,").fontWeight(.black)
                                    Text(" when tasks are due, you'll see:")
                                } else {
                                    Text("Marking ") +
                                    Text("COMPLETED ").fontWeight(.black) +
                                    Text("resets the due date according to the cycle created.")
                                }
                            }
                            .foregroundStyle(.white)
                            UpkeepRow(upkeep, isCompleted: $isCompleted, startWithAnimation: true) { showEndTutorial = true }
                            Group {
                                if !isCompleted {
                                    Text("Mark the task when completed.")
                                }
                            }
                            .foregroundStyle(.white)
                            
                            if showEndTutorial {
                                Button(action: { action() }, label: {
                                    Text("Continue")
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(.white.opacity(0.95))
                                        .foregroundStyle(Color.greenDark)
                                })
                                .buttonStyle(.bordered)
                            }
                        }
                        .padding()
                    }
                }
                .tabViewStyle(.page)
            }
        }
    }
}

#Preview {
    TutorialTabView() {}
}
