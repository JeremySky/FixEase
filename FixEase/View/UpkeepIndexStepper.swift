//
//  IndexStepper.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/29/24.
//

import SwiftUI

struct UpkeepIndexStepper: View {
    
    @Binding var upkeepIndex: Int
    let item: Item
    var leftButtonIsDisabled: Bool { upkeepIndex <= 0 }
    var rightButtonIsDisabled: Bool { upkeepIndex >= item.upkeeps.count - 1 }
    
    init(_ upkeepIndex: Binding<Int>, for item: Item) {
        self._upkeepIndex = upkeepIndex
        self.item = item
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    if !leftButtonIsDisabled {
                        upkeepIndex -= 1
                    }
                },
                       label: {
                    Image(systemName: "chevron.left.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(Color.gray)
                        .opacity(leftButtonIsDisabled ? 0.3 : 1)
                        .padding(.leading, 10)
                })
                .disabled(leftButtonIsDisabled)
                Spacer()
                
                Button(action: {
                    if !rightButtonIsDisabled {
                        upkeepIndex += 1
                    }
                },
                       label: {
                    Image(systemName: "chevron.right.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(Color.gray)
                        .opacity(rightButtonIsDisabled ? 0.3 : 1)
                        .padding(.trailing, 10)
                })
                .disabled(rightButtonIsDisabled)}
            Spacer()
        }
        .padding()
    }
}

#Preview {
    UpkeepIndexStepper(.constant(0), for: Item.exRocketShip)
}
