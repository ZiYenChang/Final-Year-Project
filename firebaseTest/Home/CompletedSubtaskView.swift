//
//  CompletedSubtaskView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/03/2023.
//

import SwiftUI

struct CompletedSubtaskView: View {
    let taskTitle: String
    let subTask: SubtaskModel
    var body: some View {
        HStack(alignment: .center) {
            Text("✔️")
                .font(.headline)
            VStack(alignment: .leading) {
                Text("\(subTask.title)")
                    .font(.subheadline)
                Text("from \(taskTitle)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

struct CompletedSubtaskView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedSubtaskView(taskTitle:"hello" ,subTask: SubtaskModel.sampleData[0])
    }
}
