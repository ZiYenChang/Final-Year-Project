//
//  NearlyDueCardView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 04/03/2023.
//

import SwiftUI

struct NearlyDueCardView: View {
    let task: TaskModel
    var body: some View {
        HStack {
            Circle()
                .frame(width: 8, height: 8)
                .padding(.horizontal, 6)
                .foregroundColor(task.status.accentColor)
            
            Text(task.title)
            
            Spacer()
            
            Text(numberOfDaysBetween(to: task.deadline))
                .padding(.horizontal, 5)
                .font(.caption)
        }
    }
}

struct NearlyDueCardView_Previews: PreviewProvider {
    static var previews: some View {
        NearlyDueCardView(task: TaskModel.sampleData[0])
    }
}
