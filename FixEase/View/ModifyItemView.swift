//
//  ModifyItemView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/22/24.
//

import SwiftUI

struct ModifyItemView: View {
    
    @EnvironmentObject var viewManager: ViewManager
    @State var item: Item
    
    init(_ item: Item) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel", action: { viewManager.modifyItemIsPresenting = false })
                Spacer()
                Button("Save", action: {})
            }
            .foregroundStyle(Color.greenDark)
            .padding(.vertical)
            
            Text("Modify Item")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Text("NAME")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("i.e. Car", text: $item.name)
                    .textFieldStyle(.roundedBorder)
            }
            
            VStack {
                Text("DESCRIPTION")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("i.e. 2018 Nissan", text: $item.description)
                    .textFieldStyle(.roundedBorder)
            }
            
            VStack {
                Text("ICON")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    HStack {
                        Text("Selected:")
                        TextField("Pick an Emoji", text: $item.emoji)
                            .onChange(of: item.emoji) { oldValue, newValue in
                                item.emoji = newValue.onlyEmoji()
                            }
                    }
                    .padding(.horizontal, 8)
                    Divider()
                        .padding(.horizontal, 8)
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
                        .padding(.horizontal, 8)
                    }
                    .frame(maxHeight: 300)
                }
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.white)
                )
                Spacer()
            }
        }
        .padding(.horizontal)
        .background(.gray.opacity(0.1))
    }
}

#Preview {
    @State var viewManager = ViewManager(modifyItemIsPresenting: true)
    return Text("ASDF")
        .sheet(isPresented: $viewManager.modifyItemIsPresenting, content: {
            ModifyItemView(Item.exRocketShip)
                .environmentObject(viewManager)
        })
}
