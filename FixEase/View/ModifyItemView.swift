//
//  ModifyItemView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/22/24.
//

import SwiftUI

struct ModifyItemView: View {
    @State var item: Item
    
    init(_ item: Item) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel", action: {})
                Spacer()
                Button("Save", action: {})
            }
            .foregroundStyle(Color.greenDark)
            .padding()
            
            Text("Modify Item")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Form {
                Section("Name") {
                    TextField("i.e. Car", text: $item.name)
                }
                Section("Description") {
                    TextField("i.e. 2018 Nissan", text: $item.description)
                }
                Section("Icon") {
                    HStack {
                        Text("Selected:")
                        TextField("Pick an Emoji", text: $item.emoji)
                            .onChange(of: item.emoji) { oldValue, newValue in
                                item.emoji = newValue.onlyEmoji()
                            }
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 18) {
                            ForEach(EmojiSelection.allCases, id: \.self) { emoji in
                                Button(action: {item.emoji = emoji.rawValue}, label: {
                                    Text(emoji.rawValue)
                                        .font(.custom("Emoji Selector", size: 60))
                                })
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
        }
        .background(.gray.opacity(0.1))
    }
}

#Preview {
    Text("ASDF")
        .sheet(isPresented: .constant(true), content: {
            ModifyItemView(Item.exRocketShip)
        })
}
