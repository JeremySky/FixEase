//
//  ItemDetailView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/18/24.
//

import SwiftUI

struct ItemDetailView: View {
    
    @EnvironmentObject var viewManager: ViewManager
    @Binding var item: Item
    @State var upkeepIndex: Int
    @State var modifyNote: (string: String, isNew: Bool, index: Int?)
    
    
    
    var leftButtonIsDisabled: Bool { upkeepIndex <= 0 }
    var rightButtonIsDisabled: Bool { upkeepIndex >= item.upkeeps.count - 1 }
    
    init(_ item: Binding<Item>, upkeepIndex: Int = 0, note: (String, Bool, Int?) = ("", true, nil)) {
        self._item = item
        self._upkeepIndex = State(initialValue: upkeepIndex)
        self._modifyNote = State(initialValue: note)
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button("Back") {
                        viewManager.current = .main
                    }
                    Spacer()
                    Button("New Upkeep") {
                        // NEW UPKEEP
                    }
                }
                .padding(.horizontal)
                .foregroundStyle(.white)
                
                //MARK: -- Item Details...
                Button(action: { viewManager.modifyItemIsPresenting = true }) {
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(item.name)
                                .font(.title2.weight(.heavy))
                                .foregroundStyle(Color.greenDark)
                            Text(item.description)
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .padding(.bottom, 10)
                            Text("\(item.upkeeps.count) Upkeeps")
                                .font(.largeTitle.weight(.black).width(.compressed))
                                .foregroundStyle(Color.black.opacity(0.8))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                        Text(item.emoji)
                            .font(.custom("Item Emoji", fixedSize: 80))
                            .padding(.trailing)
                    }
                    .padding(.top, 2)
                    .padding(.bottom, 4)
                    .background(
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(LinearGradient(colors: [.white, .clear], startPoint: .center, endPoint: .trailing))
                            Spacer().frame(width: 5)
                        }
                            .shadow(radius: 10, x: -5, y: 5)
                    )
                }
                .padding()
                
                Spacer().frame(height: 40)
                
                
                //MARK: -- UpkeepDetailView...
                //WIP empty view
                if item.upkeeps.isEmpty {
                    VStack {
                        Text("EMPTY")
                        Spacer()
                    }
                } else {
                    HStack {
                        Button(action: {
                            if !leftButtonIsDisabled {
                                upkeepIndex -= 1
                            }
                        },
                               label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color.gray)
                                .opacity(leftButtonIsDisabled ? 0.3 : 1)
                        })
                        .disabled(leftButtonIsDisabled)
                        
                        
                        //MARK: -- Upkeep Details...
                        VStack {
                            Text(item.upkeeps[upkeepIndex].description)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.greenDark)
                            Text("Every 2 Years")
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray)
                            Text("\(item.upkeeps[upkeepIndex].dueDate, format: .dateTime.weekday(.wide)) \(item.upkeeps[upkeepIndex].dueDate, format: .dateTime.day().month().year())")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        
                        
                        Button(action: {
                            if !rightButtonIsDisabled {
                                upkeepIndex += 1
                            }
                        },
                               label: {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.gray)
                                .opacity(rightButtonIsDisabled ? 0.3 : 1)
                        })
                        .disabled(rightButtonIsDisabled)
                    }
                    .padding()
                    
                    
                    //MARK: -- Notes...
                    VStack(alignment: .leading) {
                        Text("Notes:")
                            .bold()
                            .padding(.horizontal)
                        List {
                            ForEach(Array(item.upkeeps[upkeepIndex].notes.enumerated()), id: \.element) { index, note in
                                Button(note) {
                                    modifyNote = (note, false, index)
                                    viewManager.modifyNoteIsPresented = true
                                }
                                .foregroundStyle(.primary)
                                .buttonStyle(.borderless)
                            }
                            Button("+ New Note") {
                                modifyNote = ("", true, nil)
                                viewManager.modifyNoteIsPresented = true
                            }
                            .foregroundStyle(Color.greenDark)
                            .buttonStyle(.borderless)
                        }
                        .listStyle(.inset)
                        .scrollIndicators(.hidden)
                    }
                    .padding()
                }
            }
            
            
            
            //MARK: -- Modify Note Sheet...
            if viewManager.modifyNoteIsPresented {
                ModifyNoteView(modifyNote.string, isNew: modifyNote.isNew) { note in
                    modifyNote.isNew ? addNote(note) : saveEditedNote(note)
                    viewManager.modifyNoteIsPresented = false
                }
            }
        }
        .sheet(isPresented: $viewManager.modifyItemIsPresenting, content: {
            ModifyItemView(item) { item in
                self.item = item
                viewManager.modifyItemIsPresenting = false
            }
        })
    }
    
    func addNote(_ note: String) {
        item.upkeeps[upkeepIndex].notes.append(note)
    }
    func saveEditedNote(_ note: String) {
        guard let index = modifyNote.index else { return }
        item.upkeeps[upkeepIndex].notes[index] = note
    }
}





#Preview {
    ContentView(viewManager: ViewManager(current: .itemDetail(Item.exRocketShip)))
        .background(ContentView.Background())
}

extension ItemDetailView {
    struct ModifyNoteView: View {
        
        @EnvironmentObject var viewManager: ViewManager
        let promptString: String
        @State var note: String
        let submit: (String) -> Void
        
        init(_ note: String, isNew: Bool, submit: @escaping (String) -> Void) {
            self.note = note
            self.promptString = { isNew ? "New Note" : "Edit Note"}()
            self.submit = submit
        }
        
        var body: some View {
            ZStack(alignment: .bottom) {
                Color.gray.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewManager.modifyNoteIsPresented = false
                    }
                HStack {
                    TextField("", text: $note, prompt: Text(promptString).foregroundStyle(.white.opacity(0.6)))
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
}
