//
//  TaskModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Foundation

struct TaskModel: Identifiable, Codable, Equatable {
    var id: String?
    var title: String
    var note: String
    var status: Status
    var deadline: Date
    var lastUpdate: String
    var uid: String?
}

//an extension for new empty details, so that don't need to retype the parameters
extension TaskModel{
    //use static so don't need to initialise it
    static var new: TaskModel{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        
        return TaskModel(title: "",
                         note: "",
                         status: .notStarted,
                         deadline: Date(),
                         lastUpdate: dateFormatter.string(from: Date())
                  )
    }
}

extension TaskModel {
    static let sampleData: [TaskModel] =
    [
        TaskModel(title: "Groupwork",
                  note: "This is the note",
                  status: .notStarted,
                  deadline: Date(),
                  lastUpdate:" "),
        TaskModel(title: "Groupwork 1",
                  note: "This is the note",
                  status: .notStarted,
                  deadline: Date(),
                  lastUpdate: "")
    ]
}
