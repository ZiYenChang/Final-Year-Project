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
    @State private var data: [MoodChartData] = []
    
    @State private var isMoodSelected: Bool = false
    var body: some View {
        
        VStack {
            VStack {
                Text("Are you satisfied with today's progress?☺️")
                if (!isMoodSelected){
                    MoodInputCardView(isMoodSelected: $isMoodSelected)
                        .padding(.horizontal, 10)
                }
                
                Spacer()
                ForEach(vm.moods){ mood in
                    Text("The mood is \(mood.mood)")
                }
            }//end vstack
            .animation(.easeInOut(duration: 0.2), value: isMoodSelected)
            .onAppear{
                vm.moodlistenDatabase()
                print(data)
                for mood in vm.moods{
                    var iD = 0
                    data.append(MoodChartData(lastUpdate: mood.lastUpdate, mood: mood.mood, id: iD))
                    print(data)
                    iD = iD + 1
                }
            }
            .onDisappear{
                vm.moodStopListening()
            }
            
            if (vm.moods != []){
                MoodChartView(rawData: $vm.moods)
            }
            
        }
        
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView()
    }
}
