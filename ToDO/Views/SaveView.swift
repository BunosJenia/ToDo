//
//  SaveView.swift
//  ToDO
//
//  Created by Yauheni Bunas on 6/2/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SwiftUI

struct SaveView: View {
    @State var title = ""
    @State var message = ""
    @Binding var isAddNewMode: Bool
    @EnvironmentObject var toDoObserver: ToDoObserver
    var toDo: toDoType
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Spacer()
                
                Button(action: {
                    if self.toDo.id != "" {
                        self.toDoObserver.update(id: self.toDo.id, message: self.message, title: self.title)
                    } else {
                        self.toDoObserver.add(title: self.title, message: self.message, date: Date())
                    }
                    
                    self.isAddNewMode.toggle()
                }) {
                    Text("Save")
                }
            }
            
            TextField("Title", text: $title)
            MultilineView(text: $message)
        }
        .padding()
        .onAppear {
            self.title = self.toDo.title
            self.message = self.toDo.message
        }
    }
}
