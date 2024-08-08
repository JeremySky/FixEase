//
//  WelcomeView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 8/7/24.
//

import SwiftUI

struct WelcomeView: View {
    @State var name: String = ""
    let submit: (String) -> Void
    
    var body: some View {
        VStack {
            VStack {
                Text("Welcome to")
                Text("FIXEASE")
                    .font(.custom(Font.rubikMonoOne, fixedSize: 50))
                Text("Maintenance made simple!")
            }
            .foregroundStyle(.white)
            .padding(.top)
            Spacer()
            VStack(alignment: .leading) {
                Text("Lets start with a name...")
                    .padding(.bottom)
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit { submit(name) }
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    WelcomeView() { _ in }
}
