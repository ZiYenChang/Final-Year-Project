//
//  ShowTaskDetailsView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI
import ConfettiSwiftUI

struct ShowTaskDetailsView: View {
    
    var task: TaskModel
    @State private var showUpdateTask = false
    @ObservedObject var vm: ShowAllTasksViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var confetti = 0
    
    
    
    var body: some View {
        
        List {
            if task.status == Status.completed{
                VStack(alignment: .center, spacing: 3){
                    Text("Congrats! You have completed this task!")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundColor(Color(red: 0, green: 0.5, blue: 0))
                        .fontWeight(.semibold)
                    Text("🥳 🥳 🥳")
                        .multilineTextAlignment(.center)
                        .font(.title2)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 5)
                .listRowBackground(Color.white.opacity(0.9))
            }
            
            Section(header: Text("Task Info")) {
                HStack {
                    Label(task.title, systemImage: "mappin")
                    Spacer()
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
        .background(Image("tiffany-waves")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea())
        .scrollContentBackground(.hidden)
        .safeAreaInset(edge: .bottom, content: {
            
            VStack {
                if task.status.rawValue != Status.completed.rawValue{
                    Button(action: {
                        vm.completeTask(with: task)
                        confetti += 1
                        vm.listentoRealtimeDatabase()
                    }) {
                        Text("Mark as completed")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .frame(width:350)
                    .background(.white)
                    .cornerRadius(8)

                }
                
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
                .frame(width:350)
                .background(.white)
                .cornerRadius(8)
                .padding(.bottom)
                .confettiCannon(counter: $confetti, num: 80, radius: 750.0)
            }
            // https://www.appcoda.com/swiftui-confetti-animation/
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
                        showTaskvm: vm, confetti: $confetti
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
