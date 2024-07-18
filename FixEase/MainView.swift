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
            .padding([.top, .horizontal])
            
            //MARK: -- Items List View...
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    ForEach(1..<10) { item in
                        NavigationLink {
                            Text("🌻")
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 78)
                                    .foregroundStyle(Color.white)
                                    .shadow(radius: 10)
                                Text("🌻")
                                    .font(.custom("Item Button", fixedSize: 45))
                            }
                        }

                    }
                }
                .padding()
            }
            
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
                        UpkeepRowView((description: "Water Flowers", dueDate: Date(), emoji: "🌻"))
                    }
                }
                .padding()
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
