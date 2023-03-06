//
//  MoodChartView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 21/02/2023.
//

import SwiftUI
import Charts

func moodModelForChart(rawData: Array<MoodModel>) -> Array<MoodChartData> {
    var moodChart:[MoodChartData] = []
    
    for mood in rawData{
        var iD = 0
        moodChart.append(MoodChartData(lastUpdate: mood.lastUpdate, mood: mood.mood, id: iD))
        print(moodChart)
        iD = iD + 1
    }
    
    return moodChart
}

struct MoodChartView: View {
    @Binding var rawData: [MoodModel]
    @State var data: [MoodChartData] = []
    
    private func isToday(value: AxisValue) -> Bool {
        let dateValue = value.as(Date.self)!
        return Calendar.current.isDateInToday(dateValue)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("February")
                .padding(.horizontal)
            ZStack(alignment: .leading) {
                ScrollViewReader { value in
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(alignment: .leading) {
                            Chart(data) {eachData in
                                LineMark(
                                    x: .value("Date", eachData.date, unit: .day),
                                    y: .value("Mood", eachData.mood)
                                )
                                .interpolationMethod(.catmullRom)
                                .symbol() {
                                    Text(emojiIdentifier(mood: eachData.mood))
                                }
                                .symbolSize(30)
                                .foregroundStyle(.linearGradient(colors: [.red, .yellow], startPoint: .bottom, endPoint: .top))
                            } // end chart
                            .chartYScale(domain:0 ... 10)
//                            .chartXScale(domain: data[0].date.addingTimeInterval(-86400) ... data[Int(data.count-1)].date.addingTimeInterval(86400*3),
//                                         range: .plotDimension(startPadding: 10, endPadding: -52))
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
                            .padding()
                            .frame(width: ((CGFloat(data.count)+3)/7 * 350.0), height: 200)
                            
                            // to ensure the graph starts from the end
                            HStack{
                                ForEach(0..<(data.count), id: \.self) { i in
                                    Text("\(data[i].date, format: .dateTime.day())")
                                        .font(.caption)
                                        .padding(.trailing, 29)
                                        .id(i)
                                        .opacity(0.2)
                                }
                                .offset(x:54, y:-22)
                            } //end hstack
                        } // end vstack
                        .onAppear{
                            value.scrollTo(data.count - 1)
                            data = moodModelForChart(rawData: rawData)
                        }
                    } // end scrollview
                }// end scrollview reader
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 34, height: 200)
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
                        .padding(.bottom, 38)
                        .foregroundColor(.gray)
                        
                }
                .frame(height: 200)
                .padding(.leading, 16)
            } //end vstack
        }
    }
    
//    private func emojiIdentifier2(mood: PlottableValue<<#Value: Plottable#>>) -> String {
//        if (mood == 0.0 || mood == 0.5){
//            return MoodEmoji.zero.emoji
//        } else if (mood == 1.0 || mood == 1.5){
//            return MoodEmoji.one.emoji
//        } else if (mood == 2.0 || mood == 2.5){
//            return MoodEmoji.two.emoji
//        } else if (mood == 3.0 || mood == 3.5){
//            return MoodEmoji.three.emoji
//        } else if (mood == 4.0 || mood == 4.5){
//            return MoodEmoji.four.emoji
//        } else if (mood == 5.0 || mood == 5.5){
//            return MoodEmoji.five.emoji
//        } else if (mood == 6.0 || mood == 6.5){
//            return MoodEmoji.six.emoji
//        } else if (mood == 7.0 || mood == 7.5){
//            return MoodEmoji.seven.emoji
//        } else if (mood == 8.0 || mood == 8.5){
//            return MoodEmoji.eight.emoji
//        } else if (mood == 9.0 || mood == 9.5){
//            return MoodEmoji.nine.emoji
//        } else if (mood == 10.0 || mood == 10.5){
//            return MoodEmoji.ten.emoji
//        }
//        return "error"
//    }
}


//struct MoodChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoodChartView(data:[MoodChartData(lastUpdate: "22:03 Tue, 11 Feb 2023", mood: 6.5, id: 0),
//                            MoodChartData(lastUpdate: "22:03 Tue, 12 Feb 2023", mood: 7.5, id: 1),
//                            MoodChartData(lastUpdate: "22:03 Tue, 13 Feb 2023", mood: 3.5, id: 2),
//                            MoodChartData(lastUpdate: "22:03 Tue, 14 Feb 2023", mood: 6.5, id: 3),
//                            MoodChartData(lastUpdate: "22:03 Tue, 15 Feb 2023", mood: 8.5, id: 4),
//                            MoodChartData(lastUpdate: "22:03 Tue, 16 Feb 2023", mood: 7.5, id: 5),
//                            MoodChartData(lastUpdate: "22:03 Tue, 17 Feb 2023", mood: 9.5, id: 6),
//                            MoodChartData(lastUpdate: "22:03 Tue, 18 Feb 2023", mood: 8.5, id: 7),
//                            MoodChartData(lastUpdate: "22:03 Tue, 19 Feb 2023", mood: 7.5, id: 8),
//                            MoodChartData(lastUpdate: "22:03 Tue, 20 Feb 2023", mood: 9.5, id: 9),
//                            MoodChartData(lastUpdate: "22:03 Tue, 21 Feb 2023", mood: 8.5, id: 10),
//                            MoodChartData(lastUpdate: "22:03 Tue, 22 Feb 2023", mood: 7.5, id: 11),
//                            MoodChartData(lastUpdate: "22:03 Tue, 23 Feb 2023", mood: 9.5, id: 12),
//                            MoodChartData(lastUpdate: "22:03 Tue, 24 Feb 2023", mood: 9.5, id: 13)])
//    }
//}
