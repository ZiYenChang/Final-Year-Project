//
//  MoodCalendarView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 08/03/2023.
//

import SwiftUI

struct MoodCalendarView: View {
    @State private var currentDate = Date()
    private let daysOfWeek = ["M", "T", "W", "T", "F", "S", "S"]
    private let calendar = Calendar.current
    var data: [MoodChartData]
    @State private var changeCalendar = false
    
    var body: some View {
        VStack (spacing: 0) {
            // Previous and next month buttons
            HStack {
                Spacer()
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate)!
                    changeCalendar.toggle()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }
                Spacer()
                // Month and year header
                Text(currentDate.monthString() + " " + currentDate.yearString())
                    .frame(width: 170)
                    .animation(.easeInOut, value: changeCalendar)
                Spacer()
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
                    changeCalendar.toggle()
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding(.vertical,10)
            
            
            // Days of the week header
            HStack(spacing: 0) {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .font(.caption)
                }
            }
            Divider()
                .padding(.bottom, 3)
            
            // Days grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), alignment: .center), count: 7), spacing: 0) {
                ForEach(days(), id: \.self) { date in
                    VStack {
                        Text(date.dayString())
                            .font(.caption)
                            .fontWeight(date.isToday() ? .bold : .none)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(date.month != currentDate.month ? .gray.opacity(0.4) : .primary)
                            .background(date.isToday() && date.month == currentDate.month ? Color.yellow.opacity(0.5) : Color.clear)
                            .cornerRadius(9)
                                
                        Text(checkEmoji(data:data, date: date))
                            .opacity(checkEmoji(data:data, date: date) == "😶‍🌫️" ? 0.4 : 0.9)
                            .foregroundColor(date.month != currentDate.month ? .clear : .primary)
                            .font(.title)
                    }
                    .padding(.top, 6)
                    .padding(.bottom, 6)
                }
                .animation(nil, value: changeCalendar)
            }
//            .background(Color.gray.opacity(0.2))
            .animation(.easeInOut(duration: 0.4), value: changeCalendar)
            .gesture(
                DragGesture(minimumDistance: 50, coordinateSpace: .local)
                    .onEnded { value in
                        if value.translation.width < 0 {
                            // swipe left detected
                            self.currentDate = Calendar.current.date(byAdding: .month, value: 1, to: self.currentDate)!
                            changeCalendar.toggle()
                        } else if value.translation.width > 0 {
                            // swipe right detected
                            changeCalendar.toggle()
                            self.currentDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentDate)!
                        }
                    }
            )
            
            
        }
    }
    
    private func checkEmoji(data: [MoodChartData], date: Date) -> String{
        var emoji = "😶‍🌫️"
        for object in data{
            if Calendar.current.isDate(object.date, inSameDayAs: date){
                emoji = emojiIdentifier(mood: object.mood)
            }
        }
        
        return emoji
    }
    
    // Get an array of dates for the current month, with leading/trailing days to fill the grid
    private func days() -> [Date] {
        let startOfMonth = currentDate.startOfMonth()
        let startDayOfWeek = startOfMonth.startOfWeek(startingOn: .monday)
        
        var date = startDayOfWeek
        
        if calendar.component(.day, from: startOfMonth) == 1 && calendar.component(.weekday, from: startOfMonth) == 1 {
//            date = startOfMonth
            date = calendar.date(byAdding: .day, value: -7, to: date)!
        }
        
        var days = [Date]()
        
        while days.count < 42 {
            days.append(date)
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
        
        return days
            
    }
}

extension Date {
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
    
    func startOfWeek(startingOn: DayOfWeek) -> Date {
        let cal = Calendar(identifier: .gregorian)
        var components = cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        components.weekday = startingOn.rawValue
        return cal.date(from: components)!
    }
    
    func isToday() -> Bool {
        let today = Date()
        return self.year == today.year && self.month == today.month && self.day == today.day
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func yearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    func monthString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    func dayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
    
    
}

enum DayOfWeek: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
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
     
    }
}
