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
    
    @State private var readyInput = false
    
    @State private var isMoodSelected: Bool = false
    var body: some View {
        
        
        ScrollView {
            VStack {
//                if isAfterTime(time: 11) && todayInput(moods: vm.moods){
                if todayInput(moods: vm.moods){
                    VStack {
                        if !readyInput {
                            Image("work")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150.0)
                            Text("Hey \(sessionService.userDetails?.firstName ?? " ")")
                                .frame(maxWidth: .infinity)
                                .font(.title2)
                                .fontWeight(.medium)
                                .padding(.bottom, 1)
                            Text("Have you call it a day with your work?")
                                .frame(maxWidth: .infinity)
                                .font(.subheadline)
                            
                            Button(action: {
                                readyInput = true
                            }) {
                                Text("Yes")
                                    .padding(.horizontal)
                            }
                            .foregroundColor(.black)
                            .cornerRadius(9)
                            .buttonStyle(.bordered)
                            
                        }else{
                            HStack {
                                Button(action: {
                                    readyInput = false
                                }) {
                                    HStack{
                                        Image(systemName: "chevron.backward")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                        Text("Back")
                                    }
                                }
                                Spacer()
                            }
                            .padding(.bottom, 10)
                            MoodInputCardView(isMoodSelected: $isMoodSelected)
                                .environmentObject(vm)
                        }
                        
                    }//end vstack
                    .animation(.easeInOut(duration: 0.2), value: readyInput)
                    .padding(.vertical)
                    .padding(.horizontal,12)
                    .background(.white.opacity(0.9))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
                    .animation(.easeInOut(duration: 0.2), value: isMoodSelected)
                    .animation(.easeInOut(duration: 0.2), value: readyInput)
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
//                vm.moodStopListening()
            }
        }
        .background(Image("yellow-pink-gradient"))
        
        
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
