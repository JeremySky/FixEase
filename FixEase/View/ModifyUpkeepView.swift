//
//  ModifyUpkeepView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/23/24.
//

import SwiftUI

struct ModifyUpkeepView: View {
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    @State var upkeep: Upkeep
    let submit: (Upkeep) -> Void
    
    var isNew: Bool
    
    init(_ upkeep: Upkeep = Upkeep(), submit: @escaping (Upkeep) -> Void) {
        self.upkeep = upkeep
        self.submit = submit
        self.isNew = upkeep.isEmpty
    }
    
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Button("Cancel", action: { dismiss() })
                Spacer()
                Button(isNew ? "Add" : "Save") {
                    submit(upkeep)
                    dismiss()
                }
            }
            .foregroundStyle(Color.greenDark)
            .padding(.top)
            
            Text(isNew ? "New Upkeep" : "Modify Upkeep")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Text("DESCRIPTION")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    TextField("i.e. Car Wash", text: $upkeep.description)
                        .focused($isFocused)
                        .onSubmit {
                            isFocused = false
                        }
                        .textFieldStyle(.roundedBorder)
                    if isFocused {
                        Button(role: .destructive, action: { upkeep.description = "" }) {
                            Image(systemName: "x.square")
                                .font(.title2)
                        }
                        .disabled(upkeep.description.isEmpty)
                    }
                }
            }
            
            VStack {
                Text("DUE DATE")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                DatePicker("Next Due Date", selection: $upkeep.dueDate, displayedComponents: .date)
                .padding(.horizontal, 6)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.white)
                )
            }
            
            VStack {
                Text("CYCLE")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    HStack {
                        Text("Every:")
                        Spacer()
                        Stepper(upkeep.cycle.description, value: $upkeep.cycle.unit)
                            .frame(width: 180)
                    }
                    HStack {
                        Text("Unit")
                        Spacer()
                        Picker("Unit", selection: $upkeep.cycle.rule) {
                            ForEach(Upkeep.Cycle.Rule.allCases) { rule in
                                Text(upkeep.cycle.unit == 1 ? rule.singularDescription : rule.pluralDescription)
                            }
                        }
                    }
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.white)
                )
            }
            Spacer()
        }
        .padding(.horizontal)
        .background(.gray.opacity(0.1))
        .onAppear{isFocused = isNew}
    }
}

#Preview {
    @State var id: UUID? = Item.exRocketShip.id
    return ContentView(selectedItemID: id)
}
