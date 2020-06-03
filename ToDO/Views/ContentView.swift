//
//  ContentView.swift
//  ToDO
//
//  Created by Yauheni Bunas on 6/2/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isEditMode = false
    @State var isAddNewMode = false
    @EnvironmentObject var toDoObserver: ToDoObserver
    @State var selected: toDoType = .init(id: "", title: "", message: "", time: "", day: "")
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.bottom)
            
            VStack {
                VStack(spacing: 5) {
                    HStack {
                        Text("To Do")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Spacer()
                        
                        Button(action: {
                            self.selected = toDoType(id: "", title: "", message: "", time: "", day: "")
                            self.isEditMode.toggle()
                        }) {
                            Text(self.isEditMode ? "Done" : "Edit")
                        }
                    }
                    .padding([.leading, .trailing], 15)
                    .padding(.top, 10)
                    
                    Button(action: {
                        self.isAddNewMode.toggle()
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding()
                    }
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .clipShape(Circle())
                    .padding(.bottom, -15)
                    .offset(y: 15)
                }
                .background(Rounded().fill(Color.white))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        Text("" )
                        ForEach(self.toDoObserver.datas) { observer in
                            CellView(isEditMode: self.isEditMode, data: observer)
                                .onTapGesture {
                                    self.selected = observer
                                    self.isAddNewMode.toggle()
                                }
                        }
                    }
                    .padding()
                    .padding(.top, 15)
                }
            }
            .sheet(isPresented: self.$isAddNewMode) {
                SaveView(isAddNewMode: self.$isAddNewMode, toDo: self.selected).environmentObject(self.toDoObserver)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
