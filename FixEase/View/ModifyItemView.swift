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
        self._item = State(initialValue: item)
    }
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Button("Cancel", action: { viewManager.modifyItemIsPresenting = false })
                Spacer()
                Button("Save", action: {})
            }
            .foregroundStyle(Color.greenDark)
            .padding(.top)
            
            Text("Modify Item")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Text("NAME")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    TextField("i.e. Car", text: $item.name)
                        .textFieldStyle(.roundedBorder)
                    Button(role: .destructive, action: { item.name = "" }) {
                        Image(systemName: "x.square")
                            .font(.title2)
                    }
                    .disabled(item.name.isEmpty)
                }
            }
            
            VStack {
                Text("DESCRIPTION")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    TextField("i.e. 2018 Nissan", text: $item.description)
                        .textFieldStyle(.roundedBorder)
                    Button(role: .destructive, action: { item.description = "" }) {
                        Image(systemName: "x.square")
                            .font(.title2)
                    }
                    .disabled(item.description.isEmpty)
                }
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
    @State var item = Item.exRocketShip
    return Text("ASDF")
        .sheet(isPresented: $viewManager.modifyItemIsPresenting, content: {
            ModifyItemView(item)
                .environmentObject(viewManager)
        })
}
