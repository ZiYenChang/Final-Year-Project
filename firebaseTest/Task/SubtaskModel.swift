//
//  SubtaskModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 07/02/2023.
//

import Foundation

struct SubtaskModel: Identifiable, Codable, Equatable, Hashable {
    var id: String?
    var title: String
    var completed: Bool
    var lastUpdate: String
    var taskid: String?
    var uid: String?
    var completeDate: String?
}

//an extension for new empty details, so that don't need to retype the parameters
extension SubtaskModel{
    //use static so don't need to initialise it
    static var new: SubtaskModel{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        
        return SubtaskModel(title: "",
                            completed: false,
                            lastUpdate: dateFormatter.string(from: Date())
                  )
    }
}

extension SubtaskModel{
    
    static let sampleData: [SubtaskModel] =
    [
        SubtaskModel(title: "1234",
                  completed: false,
                  lastUpdate: "15:36 Sun, 19 Mar 2023",
                  completeDate: "15:36 Sun, 19 Mar 2023"),
    ]
}
