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
        iD = iD + 1
    }
    
    return moodChart
}

struct MoodChartView: View {
    @EnvironmentObject var vm: GetMoodViewModel
    @State var data: [MoodChartData] = []
    @State private var lineView = true
    
    
    private func isToday(value: AxisValue) -> Bool {
        let dateValue = value.as(Date.self)!
        return Calendar.current.isDateInToday(dateValue)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text("Your satisfaction trend ")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    lineView.toggle()
                }, label: {
                    Image(systemName: lineView ? "calendar" : "chart.xyaxis.line")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                })
            }
            .padding(.top)
            .padding(.horizontal)
            
            if lineView {
                MoodLineView(data: moodModelForChart(rawData: vm.moods))
                    .padding(.trailing,5)
            } else{
                MoodCalendarView(data: moodModelForChart(rawData: vm.moods))
                    .padding(.horizontal, 5)
            }
            
        } //end vstack
        .animation(.easeInOut(duration: 0.3), value: lineView)
        .onAppear{
//            data = moodModelForChart(rawData: vm.moods)
        }
        .background(.white.opacity(0.9))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4.5, x: 0, y: 0)
        .padding()
    } // end body
    
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
