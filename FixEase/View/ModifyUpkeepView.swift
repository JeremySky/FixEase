//
//  ModifyUpkeepView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/23/24.
//

import SwiftUI

struct ModifyUpkeepView: View {
    
    @EnvironmentObject var viewManager: ViewManager
    @Binding var upkeep: Upkeep
    
    @State var unit: Int = 1
    
    init(_ upkeep: Binding<Upkeep>) {
        self._upkeep = upkeep
    }
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Button("Cancel", action: { viewManager.modifyUpkeepIsPresenting = false })
                Spacer()
                Button("Save", action: {})
            }
            .foregroundStyle(Color.greenDark)
            .padding(.top)
            
            Text("Modify UPKEEP")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Text("DESCRIPTION")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("i.e. Car Wash", text: $upkeep.description)
                    .textFieldStyle(.roundedBorder)
            }
            
            VStack {
                Text("DUE DATE")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("Enter Next Due Date")
                    Spacer()
                    Text("8/01/2024")
                }
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
                        Text("Rule")
                        Spacer()
                        Text("(Unit) Years")
                    }
                    Divider()
                    Stepper("Unit: \(unit)", value: $unit)
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
    }
}

#Preview {
    @State var viewManager = ViewManager(modifyItemIsPresenting: true)
    @State var upkeep = Item.exRocketShip.upkeeps[0]
    return Text("ASDF")
        .sheet(isPresented: $viewManager.modifyItemIsPresenting, content: {
            ModifyUpkeepView($upkeep)
                .environmentObject(viewManager)
        })
}
