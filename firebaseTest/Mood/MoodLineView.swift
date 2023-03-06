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
        
        ScrollView(.horizontal, showsIndicators: false){
            Chart(data) { eachData in
                LineMark(
                    x: .value("Date", eachData.date, unit: .day),
                    y: .value("Mood", eachData.mood)
                )
                .interpolationMethod(.catmullRom)
                .symbol() {
                    Text(emojiIdentifier(mood: eachData.mood))
                }
                .symbolSize(30)
            } // end chart
            .chartYScale(domain:0 ... 10)
            .chartXScale(domain: data[0].date.addingTimeInterval(-86400) ... data[Int(data.count-1)].date.addingTimeInterval(86400*3),
                         range: .plotDimension(startPadding: 0, endPadding: -50))
            .chartXAxis{
                AxisMarks(values: .stride(by: .day)){ value in
                    if let dateValue = value.as(Date.self){
                        AxisValueLabel(format: .dateTime.day().month(.defaultDigits),centered: true)
                            .foregroundStyle(Calendar.current.isDateInToday(dateValue) ? Color.blue : Color.gray)
                    }
                        
                }
            }
            .chartYAxis{
                AxisMarks(position: .leading)
            }
            .padding()
            .frame(width: 1000, height: 200)
            
        }
    }
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
