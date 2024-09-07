//
//  MainView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/17/24.
//

import SwiftUI


struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @State var newItemIsPresented: Bool = false
    @State var nameChangeIsPresented: Bool = false
    @State var deleteAccountAlert: Bool = false
    
    
    init(viewModel: MainViewModel, newItemIsPresented: Bool = false) {
        self.viewModel = viewModel
        self.newItemIsPresented = newItemIsPresented
    }
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Spacer()
                Menu {
                    Button("Change Name") { nameChangeIsPresented = true }
                    Button("Delete Account") { deleteAccountAlert = true }
                } label: {
                    Image(systemName: "gearshape")
                        .foregroundStyle(.white)
                }
                
            }
            .foregroundStyle(.white)
            .padding(.horizontal)
            
            
            //MARK: -- Welcome message...
            VStack(alignment: .leading) {
                Text("Hello, \(viewModel.user?.name ?? String("Friend"))")
                    .font(.title.weight(.bold))
                Text("Keep your valuables in prime condition.")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.white)
            .padding(.top, 8)
            .padding(.horizontal)
            
            
            
            //MARK: -- Items List View...
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 17) {
                    ForEach(viewModel.collection) { item in
                        Button { viewModel.selectedItemID = item.id } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 78)
                                    .foregroundStyle(Color.white)
                                    .shadow(radius: 10)
                                Text(item.emoji)
                                    .font(.custom("Item Button", fixedSize: 45))
                            }
                        }
                    }
                    
                    Button { newItemIsPresented = true } label: {
                        ZStack {
                            Circle()
                                .frame(width: 78)
                                .foregroundStyle(Color.white)
                                .shadow(radius: 10)
                            Text("+")
                                .font(.largeTitle.weight(.black))
                                .foregroundStyle(.greenDark)
                        }
                    }
                }
                .padding()
            }
            
            
            
            //MARK: -- Upkeeps List...
            if !viewModel.collection.isEmpty {
                HStack {
                    Text("Due Now")
                        .font(.largeTitle.weight(.heavy))
                        .foregroundStyle(Color.greenLight)
                    Spacer()
                }
                .padding(.horizontal)
            } else {
                Text("Add an item to your collection...")
                    .foregroundStyle(.gray)
                    .padding(.top)
            }
            
            //list...
            if !viewModel.dueNow.isEmpty {
                ScrollView {
                    VStack(spacing: 30) {
                        ForEach($viewModel.dueNow, id: \.self.upkeep.id) { $value in
                            UpkeepRow(value.upkeep, isCompleted: $value.isCompleted) {
                                //                            update collection[i].upkeeps[j].dueDate
                                viewModel.refreshDueDate(upkeep: value.upkeep)
                                //                            remove or move to bottom of viewModel.dueNow
                                withAnimation {
                                    viewModel.moveUpkeepToBottomOfList(id: value.upkeep.id)
                                }
                            }
                        }
                    }
                    .padding()
                }
            } else {
                Image("relax")
                    .resizable()
                    .scaledToFit()
                    .padding()
                if viewModel.dueNow.isEmpty && !viewModel.collection.isEmpty {
                    Text("Relax, all tasks are complete!")
                        .foregroundStyle(.gray)
                }
                Spacer()
            }
        }
        .sheet(isPresented: $newItemIsPresented, content: {
            ModifyItemView() { viewModel.addItem($0) }
        })
        .sheet(isPresented: $nameChangeIsPresented, content: {
            NameChangeView(newName: viewModel.user!.name) { viewModel.changeName(to: $0) }
        })
        .alert(
            "Delete Account",
            isPresented: $deleteAccountAlert,
            actions: {
                Button("Delete", role: .destructive, action: { viewModel.deleteAccount() })
            },
            message: {
                Text("This action is irreversible and will permanently remove all your data, settings, and associated content.\nOnce deleted, you will not be able to recover your account.")
            }
        )
    }
}

#Preview {
    @State var viewModel = MainViewModel(user: User.test, collection: [], selectedItemID: nil, dueNow: [])
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    return MainView(viewModel: viewModel)
        .background(
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        Ellipse()
                            .frame(width: 1550, height: 350)
                            .foregroundStyle(Gradient(colors: [Color.greenLight, Color.greenDark]))
                            .rotationEffect(isIpad ? .degrees(0) : .degrees(-7))
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(y: isIpad ? -geometry.size.height/10 : -geometry.size.height/6.3)
            }
                .ignoresSafeArea(.keyboard)
        )
}
