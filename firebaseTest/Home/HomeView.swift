//
//  HomeView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import SwiftUI
import UserNotifications

struct HomeView: View {
    //use to inject service into homeview
    //so that we can get user session detail and assign user details, and handle logout
    //Environment object passes data between parent(app) and child(home) view
    @EnvironmentObject var sessionService: SessionServiceImp
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var tabSelection: tabs
    @State private var isMoodSelected: Bool = false
    
    @StateObject var vm = ShowAllTasksViewModel()
    @StateObject var vmMood = GetMoodViewModel()
    
    @State private var numOfTask = 0
    @State private var isVideoDone = false
    @State private var hasSubtaskComplete = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14){
                //            Text("Welcome \(sessionService.userDetails?.firstName ?? " ")")
                //            Text("You are studying \(sessionService.userDetails?.courseName ?? " ").")
                //            Text("You have total of \(vm.tasks.count) tasks")
                
                //number of tasks
                if(vm.tasks != []){
                    HStack{
                        Spacer()
                        if(checkNumOfTask(tasks:vm.tasks,filter:.notStarted) != 0){
                            TaskNumCardView(title: Status.notStarted.text,
                                            taskNumber: checkNumOfTask(tasks:vm.tasks,filter:.notStarted),
                                            color: Status.notStarted.accentColor)
                        }
                        if(checkNumOfTask(tasks:vm.tasks,filter:.onTrack) != 0){
                            TaskNumCardView(title: Status.onTrack.text,
                                            taskNumber: checkNumOfTask(tasks:vm.tasks,filter:.onTrack),
                                            color: Status.onTrack.accentColor)
                        }
                        if(checkNumOfTask(tasks:vm.tasks,filter:.postponed) != 0){
                            TaskNumCardView(title: Status.postponed.text,
                                            taskNumber: checkNumOfTask(tasks:vm.tasks,filter:.postponed),
                                            color: Status.postponed.accentColor)
                        }
                        if(checkNumOfTask(tasks:vm.tasks,filter:.warning) != 0){
                            TaskNumCardView(title: Status.warning.text,
                                            taskNumber: checkNumOfTask(tasks:vm.tasks,filter:.warning),
                                            color: Status.warning.accentColor)
                        }
                        if(checkNumOfTask(tasks:vm.tasks,filter:.completed) != 0){
                            TaskNumCardView(title: Status.completed.text,
                                            taskNumber: checkNumOfTask(tasks:vm.tasks,filter:.completed),
                                            color: Status.completed.accentColor)
                        }
                        
                        Spacer()
                    } // end hstack
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .background(.regularMaterial)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4.5, x: 0, y: 0)
                    .frame(maxWidth: .infinity)
                }
                
                // Upcoming tasks
                VStack (alignment: .center){
                    if(vm.tasks != []){
                        if(checkIncompleteOverdue(tasks: vm.tasks) != []){
                            Text("Overdue")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                            
                            Text("Focus on these first")
                                .font(.caption)
                                .padding(.bottom, 6)
                            
                            
                            ForEach(checkIncompleteOverdue(tasks: vm.tasks)){ task in
                                HStack(alignment: .center) {
                                    Circle()
                                        .frame(width: 8, height: 8)
                                        .padding(.horizontal, 4)
                                        .foregroundColor(task.status.accentColor)
                                    
                                    Text(task.title)
                                        .padding(.trailing, 10)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                            }
                            
                            Button(action: {
                                self.tabSelection = .tasks
                            }) {
                                Text("Update Tasks")
                                    .padding(.horizontal,10)
                                    .padding(.vertical, 2)
                            }
                            .foregroundColor(.black)
                            .background(.gray.opacity(0.6))
                            .cornerRadius(9)
                            .buttonStyle(.bordered)
                            .padding(.vertical, 5)
                            
                        } else if(checkNext7Days(tasks: vm.tasks) != []){
                            
                            Text("Due Soon")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                            Text("In next 7 days")
                                .font(.caption)
                                .padding(.bottom, 6)
                            
                            ForEach(checkNext7Days(tasks: vm.tasks)){ task in
                                NearlyDueCardView(task: task)
                                    .padding(.horizontal, 20)
                            }
                        } else if (checkAfter7Days(tasks: vm.tasks) != []){
                                Text("CONSIDER THESE SOON ...")
                                    .foregroundColor(.secondary)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("Upcoming due")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                Text("Consider these soon")
                                    .font(.caption)
                                    .padding(.bottom, 6)
                            ForEach(checkAfter7Days(tasks: vm.tasks).prefix(3)){ task in
                                NearlyDueCardView(task: task)
                                    .padding(.horizontal, 20)
                            }
                        }
                        else if(checkIncompleteOverdue(tasks: vm.tasks) == []){
                            Text("\(sessionService.userDetails?.firstName ?? " "), you have no upcoming task due.")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                                .padding(.bottom, 3)
                            
                            Text("Take a break now or update new task!🤩")
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, 3)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                self.tabSelection = .tasks
                                // https://stackoverflow.com/questions/62504400/programmatically-change-to-another-tab-in-swiftui
                            }) {
                                Text("Go Tasks Section")
                                    .padding(.horizontal,10)
                                    .padding(.vertical, 2)
                            }
                            .foregroundColor(.black)
                            .background(.gray.opacity(0.6))
                            .cornerRadius(9)
                            .buttonStyle(.bordered)
                            .padding(.vertical, 5)
                        }
                        
                        
                    } // end if
                    else if (vm.tasks == []){
                        Text("\(sessionService.userDetails?.firstName ?? " "), you don't have any task recorded.")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                            .padding(.bottom, 3)
                        
                        Text("Add a new task now! 🤩")
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 3)
                        
                        Button(action: {
                            self.tabSelection = .tasks
                        }) {
                            Text("Go Tasks Section")
                                .padding(.horizontal,10)
                                .padding(.vertical, 2)
                        }
                        .foregroundColor(.black)
                        .background(.gray.opacity(0.6))
                        .cornerRadius(9)
                        .buttonStyle(.bordered)
                        .padding(.vertical, 5)
                        
                    }
                    
                }
                .padding()
                .background(.regularMaterial)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
                .shadow(color: Color.black.opacity(0.1), radius: 4.5, x: 0, y: 0)
                
                
                
                //                if isBeforeTime(time: 16) && isAfterTime(time: 8) && !isVideoDone{
                //                    MeditationVideoView(isVideoDone: $isVideoDone)
                //                        .animation(.easeInOut, value: isVideoDone)
                //                }
                
                //today completed task
                if(checkTodaySubtaskCompleted(subtasks: vm.subtasks) != []) {
                    VStack {
                        Text("Good Job 👏")
                            .font(.headline)
                        //                            .fontWeight(.semibold)
                        Text("Some subtasks completed today!")
                            .font(.caption)
                        ForEach(checkTodaySubtaskCompleted(subtasks: vm.subtasks)){ subtask in
                            ForEach(vm.tasks){ task in
                                if (task.id == subtask.taskid){
                                    CompletedSubtaskView(taskTitle: task.title, subTask: subtask)
                                        .padding(3)
                                        .padding(.horizontal, 20)
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.regularMaterial)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4.5, x: 0, y: 0)
                    
                }
                
                //                if isAfterTime(time: 12) && todayInput(moods: vmMood.moods){
                //                    VStack {
                //                        Text("Are you satisfied with today's progress?☺️")
                //                            MoodInputCardView(isMoodSelected: $isMoodSelected)
                //                                .environmentObject(vmMood)
                //
                //                    }//end vstack
                //                    .animation(.easeInOut(duration: 0.2), value: isMoodSelected)
                //                }
                
                //                if (checkLowMood(moods: vmMood.moods)){
                VStack{
                    LowMoodView(recentDeadline: 1)
                }
                //                }
                
            }
            .onAppear {
                //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                //                vm.listentoRealtimeDatabase()
                //                vmMood.moodlistenDatabase()
                print("listentoRealtimeDatabase() run in AllTaskView")
                NotificationManager.instance.requestAuthorization()
                NotificationManager.instance.cancelNotification()
                UIApplication.shared.applicationIconBadgeNumber = 0
                NotificationManager.instance.scheduleTimeNotification(title: "Welcome to Seed", subtitle: "Your task management companion", minutes: 0.3)
            }
            //            .onDisappear{
            //                vm.stopListening()
            //                vmMood.moodStopListening()
            //            }
            .padding(.horizontal)
        }
        .onAppear {
            vm.listentoRealtimeDatabase()
            vmMood.moodlistenDatabase()
        }
        .scrollContentBackground(.hidden)
        .background(Image("sunrise-pastel")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea())
        
    }
    private func checkNumOfTask(tasks: Array<TaskModel>, filter: Status)-> Int{
        var numOfFilteredTask:Int = 0
        for task in tasks {
            if (filter.rawValue == task.status.rawValue){
                numOfFilteredTask = numOfFilteredTask+1
            }
        }
        return numOfFilteredTask
    }
}

func checkNext7Days(tasks: Array<TaskModel>) -> Array<TaskModel>{
    var next7Days: [TaskModel] = []
    
    let startDate = Date()
    let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
    let dateInterval = DateInterval(start: startDate, end: endDate)
    
    for task in tasks {
        let deadlineWithin = dateInterval.contains(task.deadline)
        if deadlineWithin {
            next7Days.append(task)
        }
    }
    return next7Days
}

func checkAfter7Days(tasks: Array<TaskModel>) -> Array<TaskModel>{
    var after7Days: [TaskModel] = []
    
    let currentDate = Date()
    let futureDate = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)!
    
    for task in tasks {
        if task.deadline > futureDate  {
            after7Days.append(task)
        }
    }
    
    after7Days = after7Days.sorted(by: { $0.deadline < $1.deadline })
    return after7Days
}

func checkIncompleteOverdue(tasks: Array<TaskModel>) -> Array<TaskModel>{
    var result: [TaskModel] = []
    
    for task in tasks {
        if task.deadline < Date() && task.status != Status.completed{
            result.append(task)
        }
    }
    return result
}

func convertStringToDate(date: String) -> Date{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm E, d MMM y"
    let dateResult = dateFormatter.date(from: date)!
    
    return dateResult
}

func checkTodaySubtaskCompleted(subtasks: Array<SubtaskModel>) -> Array<SubtaskModel>{
    var todaySubtaskCompleted: [SubtaskModel] = []
    
    for subtask in subtasks {
        if subtask.completed == true {
            if let completeDate = subtask.completeDate {
                if Calendar.current.isDateInToday(convertStringToDate(date: completeDate)) {
                    todaySubtaskCompleted.append(subtask)
                }
            }
        }
    }
    
    return todaySubtaskCompleted
}

func checkLowMood(moods: Array<MoodModel>) -> Bool{
    let today = Date()
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    let dayBefore = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
    
    var yesterdayMood = 12.0
    var dayBeforeMood = 12.0
    var todayMood = 12.0
    
    for mood in moods {
        let moodDate = convertStringToDate(date: mood.lastUpdate)
        if Calendar.current.isDate(moodDate, inSameDayAs: yesterday) {
            print(1)
            print(moodDate)
            yesterdayMood = mood.mood
        } else if Calendar.current.isDate(moodDate, inSameDayAs: dayBefore) {
            dayBeforeMood = mood.mood
            print(2)
            print(moodDate)
        } else if Calendar.current.isDate(moodDate, inSameDayAs: today){
            todayMood = mood.mood
            print(3)
            print(moodDate)
        }
    }
    
    if yesterdayMood < 5.0 && dayBeforeMood < 5.0 && todayMood < 5.0 {
        return true
    } else{
        return false
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView(tabSelection: .constant(.home))
                .environmentObject(SessionServiceImp())
                .navigationTitle("Home")
        }
    }
}
