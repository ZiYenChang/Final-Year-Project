//
//  MoodCalendarView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 25/02/2023.
//
import Foundation
import SwiftUI

class DateHolder: ObservableObject {
    @Published var date = Date()
}


struct MoodCalendarView: View {
    @EnvironmentObject var dateHolder: DateHolder
    var data: [MoodChartData]
    
    var body: some View {
        
        VStack (spacing: 1){
            DateScrollerView()
                .environmentObject(dateHolder)
            .padding()
            
            HStack(spacing: 1){
                Text("Sun").dayLayout()
                Text("Mon").dayLayout()
                Text("Tue").dayLayout()
                Text("Wed").dayLayout()
                Text("Thu").dayLayout()
                Text("Fri").dayLayout()
                Text("Sat").dayLayout()
            } //end hstack
            
            VStack(spacing: 1){
                let daysInMonth = CalendarHelper().daysInMonth(dateHolder.date)
//                let firstDayofMonth = CalendarHelper().firstOfMonth(dateHolder.date)
                let startingDate = CalendarHelper().weekDay(dateHolder.date)
                let prevMonth = CalendarHelper().minusMonth(dateHolder.date)
                let daysInPrevMonth = CalendarHelper().daysInMonth(prevMonth)
                
                ForEach(0..<5){ row in
                    HStack(spacing: 1){
                        ForEach(0..<7){ column in
                            let count = column + (row * 7)
                            CalendarCellView(count: count,
                                             startingSpaces: startingDate,
                                             daysInMonth: daysInMonth,
                                             daysInPrevMonth: daysInPrevMonth,
                                             mood: 5.5)
                                .environmentObject(dateHolder)
                        } //end foreach
                    } //end hstack
                } //end foreach
            } // end vstack
            .frame(maxHeight: .infinity)
            
        } //end vstack
        .frame(height: 350)
    } //end view
}

struct MoodCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MoodCalendarView(data:[MoodChartData(lastUpdate: "22:03 Tue, 11 Feb 2023", mood: 6.5, id: 0),
                               MoodChartData(lastUpdate: "22:03 Tue, 12 Feb 2023", mood: 7.5, id: 1),
                               MoodChartData(lastUpdate: "22:03 Tue, 13 Feb 2023", mood: 3.5, id: 2),
                               MoodChartData(lastUpdate: "22:03 Tue, 14 Feb 2023", mood: 6.5, id: 3),
                               MoodChartData(lastUpdate: "22:03 Tue, 15 Feb 2023", mood: 8.5, id: 4),
                               MoodChartData(lastUpdate: "22:03 Tue, 16 Feb 2023", mood: 7.5, id: 5),
                               MoodChartData(lastUpdate: "22:03 Tue, 17 Feb 2023", mood: 9.5, id: 6),
                               MoodChartData(lastUpdate: "22:03 Tue, 18 Feb 2023", mood: 8.5, id: 7),
                               MoodChartData(lastUpdate: "22:03 Tue, 19 Feb 2023", mood: 7.5, id: 8),
                               MoodChartData(lastUpdate: "22:03 Tue, 20 Feb 2023", mood: 9.5, id: 9),
                               MoodChartData(lastUpdate: "22:03 Tue, 21 Feb 2023", mood: 8.5, id: 10),
                               MoodChartData(lastUpdate: "22:03 Tue, 22 Feb 2023", mood: 7.5, id: 11),
                               MoodChartData(lastUpdate: "22:03 Tue, 23 Feb 2023", mood: 9.5, id: 12),
                               MoodChartData(lastUpdate: "22:03 Tue, 24 Feb 2023", mood: 9.5, id: 13)])
            .environmentObject(DateHolder())
    }
}

extension Text{
    func dayLayout() -> some View {
        self
            .frame(maxWidth: .infinity)
            .lineLimit(1)
    }
}
