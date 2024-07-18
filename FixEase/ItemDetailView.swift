//
//  ItemDetailView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/18/24.
//

import SwiftUI

struct ItemDetailView: View {
    var body: some View {
        VStack {
            
            //MARK: -- Item Details
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(LinearGradient(colors: [.white, .clear], startPoint: .center, endPoint: .trailing))
                HStack {
                    VStack(alignment: .leading) {
                        Text("Rocket Ship")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.greenDark)
                        Text("Model LMNOP123 The American Dream")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        Text("12 Upkeeps")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .fontWidth(.compressed)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    Text("🚀")
                        .font(.custom("Item Emoji", fixedSize: 80))
                        .padding(.trailing)
                }
                .padding(.bottom, 5)
            }
            .frame(height: 120)
            .padding()
            
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    //BACK
                },
                       label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.caption)
                        Text("Back")
                    }
                })
                .foregroundStyle(.white)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Upkeep") {
                    //ADD UPKEEP
                }
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ZStack {
            ContentView.Background()
            ItemDetailView()
        }
    }
}
