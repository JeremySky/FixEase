//
//  ModifyNoteView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/29/24.
//

import SwiftUI

struct ModifyNoteView: View {
    enum FocusField: Hashable {
        case field
    }
    @FocusState private var focusedField: FocusField?
    
    @EnvironmentObject var manager: CollectionManager
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
                .onTapGesture { manager.dismiss() }
            HStack {
                TextField("", text: $note, prompt: Text(isNew ? "New Note" : "Edit Note").foregroundStyle(.white.opacity(0.6)))
                    .onSubmit { submit(note) }
                    .focused($focusedField,equals: .field)
                    .task { self.focusedField = .field }
                Button(action: { note = "" }) {
                    Image(systemName: "x.square")
                        .font(.title2)
                        .opacity(note.isEmpty ? 0.6 : 1)
                }
                .disabled(note.isEmpty)
            }
            .padding()
            .foregroundStyle(.white)
            .background( Color.black.opacity(0.7) )
        }
    }
}

#Preview {
    ZStack {
        ContentView()
        ModifyNoteView("Wash it") { _ in }
    }
}
