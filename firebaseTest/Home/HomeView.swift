//
//  HomeView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import SwiftUI

struct HomeView: View {
    //use to inject service into homeview
    //so that we can get user session detail and assign user details, and handle logout
    //Environment object passes data between parent(app) and child(home) view
    @EnvironmentObject var sessionService: SessionServiceImp
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var tabSelection: tabs
    
    @StateObject var vm = ShowAllTasksViewModel()
    
    @State private var numOfTask = 0
    
    var body: some View {
        VStack(alignment: .leading){
//            Text("Welcome \(sessionService.userDetails?.firstName ?? " ")")
//            Text("You are studying \(sessionService.userDetails?.courseName ?? " ").")
//            Text("You have total of \(vm.tasks.count) tasks")
            
            VStack (alignment: .center){
                if(vm.tasks != []){
                    
                    if(checkNext7Days(tasks: vm.tasks) != []){
                        HStack {
                            Text("NEXT 7 DAYS ...")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        HStack {
                            Text("Due soon")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        ForEach(checkNext7Days(tasks: vm.tasks)){ task in
                            NearlyDueCardView(task: task)
                        }
                    } else if (checkAfter7Days(tasks: vm.tasks) != []){
                        HStack {
                            Text("CONSIDER THESE SOON ...")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        HStack {
                            Text("Upcoming due")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        ForEach(checkAfter7Days(tasks: vm.tasks).prefix(3)){ task in
                            NearlyDueCardView(task: task)
                        }
                    }
                    else {
                        Text("\(sessionService.userDetails?.firstName ?? " "), you have no upcoming task due.")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                            .padding(.bottom, 3)
                    
                        Text("Take a break now if you have done everything!🤩")
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 3)
                        .multilineTextAlignment(.center)
                        
                        Button(action: {
                            self.tabSelection = .tasks
                        }) {
                            Text("Go Tasks Section")
                        }
                    }
                    
                    
                } // end if
                else if (vm.tasks == []){
                    Text("\(sessionService.userDetails?.firstName ?? " "), you haven't record any task yet.")
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
                    }
                    
                }
                
            }
            .padding()
            .background(.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 4.5, x: 0, y: 0)
            .frame(maxWidth: .infinity)
            
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
                .padding(.top, 15)
                .padding(.bottom, 8)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 4.5, x: 0, y: 0)
                .frame(maxWidth: .infinity)
            }
            
            Spacer()
            
        }
        .onAppear {
            vm.listentoRealtimeDatabase()
            print("listentoRealtimeDatabase() run in AllTaskView")
        }
        .padding(.horizontal)
        .showUserToolbar()
    
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView(tabSelection: .constant(.home))
                .environmentObject(SessionServiceImp())
                .navigationTitle("Home")
        }
    }
}
