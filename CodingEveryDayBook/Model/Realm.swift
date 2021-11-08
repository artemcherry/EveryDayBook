//
//  Realm.swift
//  CodingEveryDayBook
//
//  Created by Артем Вишняков on 05.11.2021.
//

import RealmSwift

class TaskModel: Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var date_start = Date()
    @Persisted var date_finish =  Date()
    @Persisted var name: String = ""
    @Persisted var descriptionTask: String = ""
}
