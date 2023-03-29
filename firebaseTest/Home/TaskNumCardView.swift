//
//  TaskNumCardView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 06/02/2023.
//

import SwiftUI

struct TaskNumCardView: View {
    let title: String
    let taskNumber: Int
    let color:Color
    var body: some View {
        VStack{
            Text(String(taskNumber))
                .font(.title)
                .foregroundColor(color)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .multilineTextAlignment(.center)
            
        
        }
        
    }
    
}

struct TaskNumCardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskNumCardView(title: "postponed", taskNumber: 4, color: .gray)
    }
}
