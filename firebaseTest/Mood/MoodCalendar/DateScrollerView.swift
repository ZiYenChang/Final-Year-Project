//
//  DateScrollerView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 25/02/2023.
//

import SwiftUI

struct DateScrollerView: View {
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        HStack{
            Spacer()
            Button {
                dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
            } label: {
                Image(systemName:  "chevron.backward")
                    .imageScale(.large)
            }
            Spacer()
            Text(CalendarHelper().monthYearString(dateHolder.date))
            Spacer()
            Button {
                dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
            } label: {
                Image(systemName:  "chevron.forward")
                    .imageScale(.large)
            }
            Spacer()
        }
    }
}

struct DateScrollerView_Previews: PreviewProvider {
    static var previews: some View {
        DateScrollerView()
            .environmentObject(DateHolder())
    }
}
