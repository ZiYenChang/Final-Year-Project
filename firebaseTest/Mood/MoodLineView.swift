//
//  MoodLineView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 25/02/2023.
//

import SwiftUI
import Charts

struct MoodLineView: View {
    var data: [MoodChartData]
    
    var body: some View {
        ZStack(alignment: .leading) {
            ScrollViewReader { value in
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Chart(data.sorted(by: { $0.date.compare($1.date) == .orderedAscending})) {eachData in
                            LineMark(
                                x: .value("Date", eachData.date, unit: .day),
                                y: .value("Mood", eachData.mood)
                            )
                            .interpolationMethod(.catmullRom)
                            .symbol() {
                                Text(emojiIdentifier(mood: eachData.mood))
                            }
                            .symbolSize(30)
                            .foregroundStyle(.linearGradient(colors: [Color(red: 0.8, green: 0.0, blue: 0.0), .yellow], startPoint: .bottom, endPoint: .top))
                        } // end chart
                        .chartYScale(domain:0 ... 10)
//                            .chartXScale(domain: data[1].date.addingTimeInterval(-86400) ... data[Int(data.count-1)].date.addingTimeInterval(86400*3),
//                                         range: .plotDimension(startPadding: 10, endPadding: -52))
//                            .chartXScale(domain: domainRange, type: ScaleType.date)
                        .chartXAxis{
                            AxisMarks(values: .stride(by: .day)){ value in
                                if let dateValue = value.as(Date.self){
                                    AxisValueLabel(format: .dateTime.day().month(.defaultDigits),centered: true)
                                        .foregroundStyle(Calendar.current.isDateInToday(dateValue) ? Color.blue : Color.gray)
                                }
                                else{
                                    AxisValueLabel(format: .dateTime.day().month(.defaultDigits),centered: true)
                                       .foregroundStyle(Color.gray)
                                }
                                    
                            }
                        }
                        .chartYAxis{
                            AxisMarks(position: .leading){ value in
                                AxisGridLine()
                            }
                        }
                        .padding(.vertical,4)
                        .padding(.leading, 15)
                        .padding(.top, 12)
//                        .frame(width: ((CGFloat(data.count)+3)/7 * 290.0), height: 220)
                        .frame(width: (((CGFloat(countDaysBetween(data: data.sorted(by: { $0.date.compare($1.date) == .orderedAscending}))))+3)/7 * 355.0), height: 220)
                        
                        // to ensure the graph starts from the end
                        HStack{
                            ForEach(0..<(countDaysBetween(data: data.sorted(by: { $0.date.compare($1.date) == .orderedAscending}))), id: \.self) { i in
//                                Text("\(data[i].date, format: .dateTime.day())")
                                Text("\(i)")
                                    .font(.caption)
                                    .padding(.trailing, 35)
                                    .id(i)
                                    .opacity(0)
                            }
                            .offset(x:54, y:-22)
                        } //end hstack
                    } // end vstack
                    .onAppear{
                        value.scrollTo((countDaysBetween(data: data.sorted(by: { $0.date.compare($1.date) == .orderedAscending}))) - 1)
                    }
                } // end scrollview
            }// end scrollview reader
            
            
            Rectangle()
                .fill(Color(red: 253/256, green: 251/256, blue: 247/256))
                .frame(width: 22, height: 220)
                .offset(x:0, y: -10)
//                    .opacity(0.5)
            VStack{
                Text("10")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Spacer()
                Text("5")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Spacer()
                Text("0")
                    .font(.caption2)
                    .padding(.bottom, 30)
                    .foregroundColor(.gray)
                    
            }
            .frame(height: 225)
            .padding(.leading, 8)
        } //end vstack
    }
    
}

import Foundation

func countDaysBetween(data: [MoodChartData]) -> Int {
    let calendar = Calendar.current
    var start = Date()
    var end = Date()
    if data != []{
        start = data[0].date
        end = data[data.count-1].date
    }
    print("start")
    print(start)
    print("end")
    print(end)
    let components = calendar.dateComponents([.day], from: start, to: end)
    return components.day ?? 0

}

struct MoodLineView_Previews: PreviewProvider {
    static var previews: some View {
        MoodLineView(data:[MoodChartData(lastUpdate: "22:03 Tue, 11 Feb 2023", mood: 6.5, id: 0),
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
