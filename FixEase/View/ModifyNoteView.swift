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
    
    @State var note: Note
    @Binding var sheetIsPresented: Sheet?
    let submit: (Note) -> Void
    
    var isNew: Bool
    
    init(_ note: Note?, _ sheetIsPresented: Binding<Sheet?>, submit: @escaping (Note) -> Void) {
        self.note = (note != nil) ? note! : Note()
        self._sheetIsPresented = sheetIsPresented
        self.submit = submit
        self.isNew = note == nil
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.gray.opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture { sheetIsPresented = nil }
            HStack {
                TextField("", text: $note.string, prompt: Text(isNew ? "New Note" : "Edit Note").foregroundStyle(.white.opacity(0.6)))
                    .onSubmit {
                        submit(note)
                        sheetIsPresented = nil
                    }
                    .focused($focusedField,equals: .field)
                    .task { self.focusedField = .field }
                Button(action: { note.string = "" }) {
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
    @State var sheetIsPresented: Sheet? = .newNote
    return ZStack {
        ContentView()
        ModifyNoteView(Note("Wash it"), $sheetIsPresented) { _ in }
    }
}
