//
//  ShowTaskView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI

struct ShowTaskCardView: View {
    let task: TaskModel
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("Title: \(task.title)")
                .font(.headline)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
            Text("Priority: \(task.priority)")
            Text("Note: \(task.note)")
//            Text("Last Update: \(task.lastUpdate ?? "")")
            Text("Id: \(task.id ?? " ")")
        }
        .padding()
        
    }
}

//struct ShowTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowTaskView()
//    }
//}
