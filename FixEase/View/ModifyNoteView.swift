//
//  ModifyNoteView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/29/24.
//

import SwiftUI

struct ModifyNoteView: View {
    @EnvironmentObject var viewManager: ViewManager
    
    @State var note: String
    var isNew: Bool
    let submit: (String) -> Void
    
    init(_ note: String, submit: @escaping (String) -> Void) {
        self.note = note
        self.isNew = note.isEmpty
        self.submit = submit
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.gray.opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture { viewManager.dismiss() }
            HStack {
                TextField("", text: $note, prompt: Text(isNew ? "New Note" : "Edit Note").foregroundStyle(.white.opacity(0.6)))
                    .onSubmit {
                        submit(note)
                    }
                Button(action: { note = "" }) {
                    Image(systemName: "x.square")
                        .font(.title2)
                        .opacity(note.isEmpty ? 0.6 : 1)
                }
                .disabled(note.isEmpty)
            }
            .padding()
            .foregroundStyle(.white)
            .background(
                Color.black.opacity(0.7)
            )
        }
    }
}

#Preview {
    ContentView(viewManager: ViewManager(current: .itemDetail(Item.exRocketShip)))
        .background(ContentView.Background())
}
