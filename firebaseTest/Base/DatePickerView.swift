//
//  DatePickerView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 01/02/2023.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var deadline: String
    
    func stringToDate() -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return formatter.date(from: deadline) ?? Date()
    }
    
    var body: some View {
//        DatePicker(selection: stringToDate()){
            Text("Deadline")
//        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(deadline: .constant("hello"))
    }
}
