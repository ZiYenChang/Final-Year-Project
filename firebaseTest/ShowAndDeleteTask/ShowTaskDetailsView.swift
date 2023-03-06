//
//  ShowTaskDetailsView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI

struct ShowTaskDetailsView: View {
    
    var task: TaskModel
    @State private var showUpdateTask = false
    @ObservedObject var vm: ShowAllTasksViewModel
    @Environment(\.presentationMode) var presentationMode
    
    
    
    var body: some View {
        List {
            Section(header: Text("Task Info")) {
                HStack {
                    Label(task.title, systemImage: "mappin")
                    Spacer()
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Priority", systemImage: "exclamationmark.circle")
                    Spacer()
                    Text("\(task.priority)")
                    
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("", systemImage: "flag")
                    TaskStatusView(status: task.status)
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("", systemImage: "clock")
                    Text(deadlineString(deadline: task.deadline))
                }
                .accessibilityElement(children: .combine)
                
                if(task.note != ""){
                    HStack {
                        VStack{
                            Label("", systemImage: "note")
                                .padding(.top, 7)
                            Spacer()
                        }
                        
                        Text(task.note)
                            
                    }
                }
            }//section end
            
            Section{
                ForEach($vm.subtasks, id: \.self){ $subtask in
                    if(subtask.taskid == task.id){
                        HStack{
                            Button(action: {
                                if(subtask.completed){
                                    subtask.completed = false
                                    vm.updateSubtask(with: subtask)
                                    vm.listentoRealtimeDatabase()
                                }else{
                                    subtask.completed = true
                                    vm.updateSubtask(with: subtask)
                                    vm.listentoRealtimeDatabase()
                                }
                                }, label: {
                                    Image(systemName: subtask.completed ? "checkmark.circle.fill" : "circle")
                                          .imageScale(.large)
                                          .foregroundColor(subtask.completed ? Color.gray : Color.blue)
                                    
                                })
                                .buttonStyle(PlainButtonStyle()) // remove any implicit styling from the button
                            
                            if(!subtask.completed){
                                Text(subtask.title)
                                    .fontWeight(.medium)
                            }else{
                                Text(subtask.title)
                                    .strikethrough()
                                    .foregroundColor(Color.gray)
                            }
//                            Spacer()
                        }
                    }// end if
                }// end foreach
            }//end section
                        
        }
        .navigationTitle(task.title)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom, content: {
            Button(role: .destructive) {
                if let id = task.id{
//                    var subtasksForDelete: [SubtaskModel] = []
//                    for subtask in vm.subtasks{
//                        if (subtask.taskid == id){
//                            subtasksForDelete.append(subtask)
//                        }
//                    }
                    vm.deleteTask(with: id)
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("Delete")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
            .background(.white)
            .frame(width:350)
            .cornerRadius(8)
            .padding(.bottom)
        })
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    showUpdateTask.toggle()
                }, label: {
                    Text("Edit")
                        .foregroundColor(.blue)
                })
                .sheet(isPresented: $showUpdateTask,
                       content: {
                    UpdateTaskView(
                        vm:UpdateTaskViewModelImp(service: UpdateTaskServiceImp(),details: task, subtasks: vm.subtasks),
                        showTaskvm: vm
                    )
//                    .onDisappear {
//                        vm.stopListening()
//                        print("listentoRealtimeDatabase() run in ShowTaskDetailsView")
//                    }
                })
                
            }
        }
        
    }
}

func deadlineString(deadline:Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm E, d MMM y"
    
    return dateFormatter.string(from: deadline)
}

//struct ShowTaskDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowTaskDetailsView()
//
//    }
//}
