//
//  NameChangeView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 9/4/24.
//

import SwiftUI

struct NameChangeView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var newName: String = ""
    var submit: (String) -> Void
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Button("Cancel", action: { dismiss() })
                Spacer()
                Button("Save") {
                    submit(newName)
                    dismiss()
                }
            }
            .foregroundStyle(Color.greenDark)
            .padding(.top)
            
            
            Text("Profile Settings")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            VStack {
                Text("Name")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    TextField("Name", text: $newName)
                        .onSubmit {
                            submit(newName)
                            dismiss()
                        }
                        .textFieldStyle(.roundedBorder)
                }
                Spacer()
            }
        }
        .padding(.horizontal)
        .background(.gray.opacity(0.1))
    }
}

#Preview {
    NameChangeView() { _ in }
}
