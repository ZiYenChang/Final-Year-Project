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
                HStack {
                    Label("Priority", systemImage: "exclamationmark.circle")
                    Spacer()
                    Text("\(task.priority)")
                }
                HStack {
                    Label("Status", systemImage: "flag")
                    Spacer()
                    TaskStatusView(status: task.status)
                        .frame(width: 130)
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("\(task.note)", systemImage: "note")
                }
                .accessibilityElement(children: .combine)
            }
                        
        }
        .navigationTitle(task.title)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom, content: {
            Button(role: .destructive) {
                if let id = task.id{
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
                        vm:UpdateTaskViewModelImp(service: UpdateTaskServiceImp(),details: task),
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

//struct ShowTaskDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowTaskDetailsView()
//
//    }
//}
