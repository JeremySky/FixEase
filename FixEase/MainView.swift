//
//  MainView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/17/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("Hello, John")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Keep your valuables in prime condition.")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.white)
            .padding()
            
            //MARK: -- Items List View...
            Rectangle()
                .frame(height: 85)
            
            HStack {
                Text("Upkeeps")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.greenLight)
                Spacer()
                Text("1/3 Complete")
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)
            
            //MARK: -- Upkeeps List...
            ScrollView {
                VStack(spacing: 35) {
                    ForEach(1..<6) { upkeep in
                        UpkeepRowView(upkeep: (description: "Water Flowers", dueDate: Date(), emoji: "🌻"))
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .toolbar {
            Button("Add Item") {
                //ADD ITEM
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
    }
}
