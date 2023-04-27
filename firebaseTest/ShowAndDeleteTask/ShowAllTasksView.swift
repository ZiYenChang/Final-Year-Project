//
//  ShowTaskView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI

//
enum StatusFilter: String, CaseIterable, Identifiable {
    case all
    case notStarted
    case onTrack
    case warning
    case postponed
    case completed
    var id: Self { self }
    
    var text: String {
        switch self {
        case .all: return "All Tasks"
        case .notStarted: return "Not Started"
        case .onTrack: return "On Track"
        case .warning: return "Warning"
        case .postponed: return "Postpone"
        case .completed: return "Completed"
        }
    }
}

struct ShowAllTasksView: View {
    @StateObject var vm = ShowAllTasksViewModel()
    @State var showAddTask = false
    @State var statusFilter: StatusFilter = .all
    @State var dateShowLatest = true
    @State var shownTask: Int = 0

    
    @EnvironmentObject var sessionService: SessionServiceImp
    
    var body: some View {
        ZStack {
            List{
                HStack{
                        Picker("Deadline", selection: $dateShowLatest) {
                            Text("Further Due").tag(true)
                            Text("Latest Due").tag(false)
                        }
                        .pickerStyle(MenuPickerStyle())
                        .labelsHidden()
                        .frame(minWidth:130)
                        
                        
                    Picker("Filter", selection: $statusFilter) {
                            ForEach(StatusFilter.allCases){ status in
                                Text(status.text).tag(status)
                                    
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .labelsHidden()
                        .frame(minWidth: 120)
                        .onChange(of: statusFilter) { _ in
                            shownTask = 0
                        }
                        
                        
                        Spacer()
                        Text("\(shownTask)/\(vm.tasks.count)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 10)
                            .background(.clear)
                            .foregroundColor(Color.clear)
                            .padding(
                                EdgeInsets(top: 2, leading: 0, bottom: 2,trailing: 0)
                            )
                    )
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0,trailing: 0))
                
                ForEach(sortByDeadline(tasks: vm.tasks, byLatest: dateShowLatest)) { task in
                    if (statusFilter.rawValue == task.status.rawValue){
                            NavigationLink(destination: ShowTaskDetailsView(task: task, vm: vm)){
                                ShowTaskCardView(task: task, vm: vm)
                            }
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
                                    shownTask += 1
                                }
                            }.onDisappear(){
                                shownTask = 0
                            }
                            .listRowSeparator(.hidden)
                            .listStyle(InsetGroupedListStyle())
                            .swipeActions(edge: .trailing){
                                if task.status != Status.completed {
                                    Button(action: {
                                        vm.completeTask(with: task)
                                        vm.listentoRealtimeDatabase()
                                    }) {
                                        Image(systemName: "checkmark.circle.fill")
                                    }
                                .tint(.blue)
                                }
                                Button(role: .destructive, action: {vm.deleteTask(with: task.id ?? "")}) {
                                    Image(systemName: "trash")
                                }
                            }
                            .listRowBackground(
                                    RoundedRectangle(cornerRadius: 10)
                                        .background(.clear)
                                        .foregroundColor(Color.white.opacity(0.9))
                                        .padding(
                                            EdgeInsets(
                                                top: 2,
                                                leading: 0,
                                                bottom: 2,
                                                trailing: 0
                                            )
                                        )
                                )
                    } else if(statusFilter.rawValue == "all"){
                            NavigationLink(destination: ShowTaskDetailsView(task: task, vm: vm)){
                                ShowTaskCardView(task: task, vm: vm)
                            }
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
                                    shownTask = vm.tasks.count
                                }
                            }
                            .onDisappear(){
                                shownTask = 0
                            }
                            .listRowSeparator(.hidden)
                            .listStyle(InsetGroupedListStyle())
                            .listRowBackground(
                                    RoundedRectangle(cornerRadius: 10)
                                        .background(.clear)
                                        .foregroundColor(Color.white.opacity(0.9))
                                        .padding(
                                            EdgeInsets(
                                                top: 2,
                                                leading: 0,
                                                bottom: 2,
                                                trailing: 0
                                            )
                                        )
                                )
                            .swipeActions(edge: .trailing){
                                if task.status != Status.completed {
                                    Button(action: {
                                        vm.completeTask(with: task)
                                        vm.listentoRealtimeDatabase()
                                    }) {
                                        Image(systemName: "checkmark.circle.fill")
                                    }
                                .tint(.blue)
                                }
                                Button(role: .destructive,
                                       action: {
                                    vm.deleteTask(with: task.id ?? "")
                                    vm.listentoRealtimeDatabase()
                                    
                                }) {
                                    Image(systemName: "trash")
                                }
                            }
                    }
                }
            }
            .onAppear {
                vm.listentoRealtimeDatabase()
                print("listentoRealtimeDatabase() run in AllTaskView")
            }
            .background(Image("tiffany-waves")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
            .scrollContentBackground(.hidden)
        
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        showAddTask.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .fontWeight(.medium)
                            .font(.title2)
                            .padding(15)
                            .foregroundColor(.black)
                            .background(
                                Circle()
                                    .fill(Color.white.opacity(0.85))
                                    .shadow(color: Color.black.opacity(0.3), radius: 4.5, x: 2, y: 2)
                            )
                    })
                    .padding()
                    .sheet(isPresented: $showAddTask) {
                        AddTaskView(vmShow:vm)
                            .onAppear{
                                vm.stopListening()
                                print("stopListening() run after addTask appear")
                            }
                    }
                }
                .padding(.trailing,20)
                .padding(.bottom,15)
            }
        }
        
    }
    
    func sortByDeadline(tasks: Array<TaskModel>, byLatest:Bool)-> Array<TaskModel>{
        var sortedArray:[TaskModel] = []
        if(byLatest){
            sortedArray = tasks.sorted(by: { $0.deadline.compare($1.deadline) == .orderedDescending })
        }else{
            sortedArray = tasks.sorted(by: { $0.deadline.compare($1.deadline) == .orderedAscending})
        }
        
        return sortedArray
    }

}



struct ShowAllTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllTasksView()
    }
}
