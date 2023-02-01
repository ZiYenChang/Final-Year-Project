//
//  TaskStatusPickerView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 25/01/2023.
//

import SwiftUI

struct TaskStatusPickerView: View {
    @Binding var selection: Status
    var body: some View {
        Picker("Status", selection: $selection) {
            ForEach(Status.allCases){ status in
                TaskStatusView(status: status)
                    .tag(status)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}

struct TaskStatusPickerView_Previews: PreviewProvider {
    static var previews: some View {
        TaskStatusPickerView(selection: .constant(.notStarted))
    }
}
