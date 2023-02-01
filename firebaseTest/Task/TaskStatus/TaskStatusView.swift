//
//  TaskStatusView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 25/01/2023.
//

import SwiftUI

struct TaskStatusView: View {
    let status: Status
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(status.accentColor)
            Text(status.text)
                .padding(2)
        }
        .foregroundColor(.black)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct TaskStatusView_Previews: PreviewProvider {
    static var previews: some View {
        TaskStatusView(status: .notStarted)
    }
}
