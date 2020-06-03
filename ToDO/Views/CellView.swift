//
//  CellVIew.swift
//  ToDO
//
//  Created by Yauheni Bunas on 6/2/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SwiftUI

struct CellView: View {
    var isEditMode: Bool
    var data: toDoType
    @EnvironmentObject var toDoObserver: ToDoObserver
    
    var body: some View {
        HStack {
            if isEditMode {
                Button (action: {
                    if self.data.id != "" {
                        self.toDoObserver.delete(id: self.data.id)
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .font(.title)
                }
                .foregroundColor(Color.red)
            }
            
            Text(data.title)
                .lineLimit(1)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 5) {
                Text(data.day)
                Text(data.time)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius:25).fill(Color.white))
        .animation(.spring())
    }
}
