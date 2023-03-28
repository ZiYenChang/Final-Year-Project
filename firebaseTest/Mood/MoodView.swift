//
//  MoodView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 14/02/2023.
//

import SwiftUI
import Charts

struct MoodChartData: Hashable, Identifiable{
    var date: Date
    var mood: Double
    var id = UUID()
    
    init(lastUpdate: String, mood: Double, id: Int) {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "HH:mm E, d MMM y"
       let originalDate = dateFormatter.date(from: lastUpdate)!
        
        self.date = originalDate
       self.mood = mood
//        self.id = id
   }
}


struct MoodView: View {
    @StateObject var vm = GetMoodViewModel()
    @EnvironmentObject var sessionService: SessionServiceImp
    
    @State private var isMoodSelected: Bool = false
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    if isAfterTime(time: 12) && todayInput(moods: vm.moods){
                        VStack {
                            Text("Are you satisfied with today's progress?☺️")
                                MoodInputCardView(isMoodSelected: $isMoodSelected)
                                    .padding(.horizontal, 10)
                                    .environmentObject(vm)
                            
                        }//end vstack
                        .animation(.easeInOut(duration: 0.2), value: isMoodSelected)
                    }
                    
                    if (vm.moods != []){
                        MoodChartView()
                            .environmentObject(vm)
//                        if (vm.moods[vm.moods.count - 1].mood < 4.5){
//                            CheerVideoView(messageID: 1)
//                                .padding(.horizontal)
//                        }
                    }
                    
                    
                    
                    Spacer()
                    
                }
                .onAppear{
                    vm.moodlistenDatabase()
                }
                .onDisappear{
                    vm.moodStopListening()
            }
            }
        }
        
    }
    
    
}

func todayInput(moods: [MoodModel]) -> Bool {
    let today = Date()
    let calendar = Calendar.current
    
    for mood in moods {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        let originalDate = dateFormatter.date(from: mood.lastUpdate)!
        
        if calendar.isDate(originalDate, inSameDayAs: today) {
            return false
        }
    }
    return true
}

func isAfterTime(time: Int) -> Bool {
    let now = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: now)
    
    return hour >= time
}

func isBeforeTime(time: Int) -> Bool {
    let now = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: now)
    
    return hour < time
}
//
//struct MoodView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoodView()
//    }
//}
