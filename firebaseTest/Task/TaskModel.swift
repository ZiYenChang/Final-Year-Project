//
//  TaskModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Foundation

struct TaskModel: Identifiable, Codable {
    var id: String?
    var title: String
    var priority: String
    var note: String
//    var lastUpdate: String?
    var uid: String?
}

//an extension for new empty details, so that don't need to retype the parameters
extension TaskModel{
    
    //use static so don't need to initialise it
    static var new: TaskModel{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm E, d MMM y"
//    lastUpdate: dateFormatter.string(from: Date())
        
        return TaskModel(title: "",
                  priority: "",
                  note: ""
                  )
    }
}

extension TaskModel {
    static let sampleData: [TaskModel] =
    [
        TaskModel(title: "Groupwork", priority: "High", note: "This is the note"),
        TaskModel(title: "Groupwork 1", priority: "Normal", note: "This is the note")
    ]
}
