//
//  RealmManager.swift
//  CodingEveryDayBook
//
//  Created by Артем Вишняков on 05.11.2021.
//

import RealmSwift

class RealmManager{
    
    static let shared = RealmManager()
    private init() {
        
    }
    let realm = try! Realm()
    
    
    func saveTask(model: TaskModel){
        try! realm.write {
            realm.add(model)
        }
    }
    
    func deleteTask(model: TaskModel){
        try! realm.write{
            realm.delete(model)
        }
    }
    
}

    

