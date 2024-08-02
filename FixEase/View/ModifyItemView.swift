//
//  ModifyItemView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/22/24.
//

import SwiftUI

struct ModifyItemView: View {
    enum FocusedField {
        case name, description, icon
    }
    @FocusState private var focusedField: FocusedField?
    @Environment(\.dismiss) private var dismiss
    
    @State var item: Item
    var isNew: Bool
    let submit: (Item) -> Void
    
    init(_ item: Item = Item(), submit: @escaping (Item) -> Void) {
        self.item = item
        self.isNew = item.isEmpty
        self.submit = submit
    }
    
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Button("Cancel", action: { dismiss() })
                Spacer()
                Button(isNew ? "Add" : "Save") {
                    submit(item)
                    dismiss()
                }
            }
            .foregroundStyle(Color.greenDark)
            .padding(.top)
            Text(isNew ? "New Item" : "Modify Item")
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
                        .focused($focusedField, equals: .name)
                        .onSubmit {
                            focusedField = .description
                        }
                    if focusedField == .name {
                        Button(role: .destructive, action: { item.name = "" }) {
                            Image(systemName: "x.square")
                                .font(.title2)
                        }
                        .disabled(item.name.isEmpty)
                    }
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
                        .focused($focusedField, equals: .description)
                        .onSubmit {
                            focusedField = .icon
                        }
                    if focusedField == .description {
                        Button(role: .destructive, action: { item.description = "" }) {
                            Image(systemName: "x.square")
                                .font(.title2)
                        }
                        .disabled(item.description.isEmpty)
                    }
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
                            .focused($focusedField, equals: .icon)
                            .onSubmit {
                                focusedField = nil
                            }
                    }
                    .padding(.horizontal, 8)
                    if focusedField == nil {
                        Divider()
                            .padding(.horizontal, 8)
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 24) {
                                ForEach(EmojiSelection.allCases, id: \.self) { emoji in
                                    Button(action: {item.emoji = emoji.rawValue}, label: {
                                        Text(emoji.rawValue)
                                            .font(.custom("Emoji Selector", size: 60))
                                    })
                                }
                                .padding(.vertical, 5)
                            }
                            .padding(.horizontal, 12)
                        }
                        .frame(maxHeight: 300)
                    }
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
        .onTapGesture {
            focusedField = nil
        }
    }
}

#Preview {
    @State var isPresenting: Bool = true
    return Text("ASDF")
        .sheet(isPresented: $isPresenting, content: {
            ModifyItemView(Item()) { _ in }
        })
}
