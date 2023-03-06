//
//  SwiftUIView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 25/02/2023.
//

import SwiftUI

struct MonthStruct
{
    var monthType: MonthType
    var dayInt : Int
    func day() -> String
    {
        return String(dayInt)
    }
}

enum MonthType
{
    case Previous
    case Current
    case Next
}

struct CalendarCellView: View {
    @EnvironmentObject var dateHolder: DateHolder
    let count : Int
    let startingSpaces : Int
    let daysInMonth : Int
    let daysInPrevMonth : Int
    let mood: Double
    
    var body: some View {
        
        VStack {
            Text(monthStruct().day())
                .foregroundColor(monthStruct().monthType == MonthType.Current ? Color.black : Color.gray)
                .font(.caption)
            Text(emojiIdentifier(mood: mood))
                .opacity(monthStruct().monthType == MonthType.Current ? 1 : 0.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            
    }
    
    func monthStruct() -> MonthStruct
        {
            let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
            if(count <= start)
            {
                let day = daysInPrevMonth + count - start
                return MonthStruct(monthType: MonthType.Previous, dayInt: day)
            }
            else if (count - start > daysInMonth)
            {
                let day = count - start - daysInMonth
                return MonthStruct(monthType: MonthType.Next, dayInt: day)
            }
            
            let day = count - start
            return MonthStruct(monthType: MonthType.Current, dayInt: day)
        }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCellView(count: 1, startingSpaces: 1, daysInMonth: 1, daysInPrevMonth: 1, mood: 5.5)
    }
}
