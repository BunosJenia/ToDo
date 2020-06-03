//
//  ToDoObserver.swift
//  ToDO
//
//  Created by Yauheni Bunas on 6/2/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SwiftUI
import CoreData

class ToDoObserver: ObservableObject {
    @Published var datas = [toDoType]()
    
    init() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        
        do {
            let result = try context.fetch(request)
            
            for todoEntity in result as! [NSManagedObject] {
                let id = todoEntity.value(forKey: "id") as! String
                let title = todoEntity.value(forKey: "title") as! String
                let message = todoEntity.value(forKey: "message") as! String
                let day = todoEntity.value(forKey: "day") as! String
                let time = todoEntity.value(forKey: "time") as! String
                
                self.datas.append(toDoType(id: id, title: title, message: message, time: time, day: day))
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func add(title: String, message: String, date: Date) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/YY"
        let day = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "hh:mm a"
        let time = dateFormatter.string(from: date)
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: context)
        
        entity.setValue("\(date.timeIntervalSince1970)", forKey: "id")
        entity.setValue(title, forKey: "title")
        entity.setValue(message, forKey: "message")
        entity.setValue(day, forKey: "day")
        entity.setValue(time, forKey: "time")
        
        do {
            try context.save()
            
            self.datas.append(toDoType(id: "\(date.timeIntervalSince1970)", title: title, message: message, time: time, day: day))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(id: String) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        
        do {
            let result = try context.fetch(request)
            
            for todoEntity in result as! [NSManagedObject] {
                if todoEntity.value(forKey: "id") as! String == id {
                    context.delete(todoEntity)
                    
                    try context.save()
                    
                    for keyValue in 0 ..< datas.count {
                        if datas[keyValue].id == id {
                            datas.remove(at: keyValue)
                            
                            return
                        }
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update(id: String, message: String, title: String) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        
        do {
            let result = try context.fetch(request)
            
            for todoEntity in result as! [NSManagedObject] {
                if todoEntity.value(forKey: "id") as! String == id {
                    
                    todoEntity.setValue(title, forKey: "title")
                    todoEntity.setValue(message, forKey: "message")
                    
                    try context.save()
                    
                    for keyValue in 0 ..< datas.count {
                        if datas[keyValue].id == id {
                            datas[keyValue].title = title
                            datas[keyValue].message = message
                        }
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

