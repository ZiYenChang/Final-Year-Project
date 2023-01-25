//
//  ShowTaskView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI

struct ShowAllTasksView: View {
    @StateObject var vm = ShowAllTasksViewModel()
    @State private var showAddTask = false
    
    var body: some View {
            ZStack {
                List{
                    Text("All tasks")
                    ForEach(vm.tasks) { task in
                        NavigationLink(destination: ShowTaskDetailsView(task: task, vm: vm)){
                            ShowTaskCardView(task: task)
                        }
                        .swipeActions(edge: .trailing){
                            Button(role: .destructive, action: {vm.deleteTask(with: task.id ?? "")}) {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    
                }
                .onAppear {
                    vm.listentoRealtimeDatabase()
                    print("listentoRealtimeDatabase() run in AllTaskView")
                }
//                .onDisappear {
//                    vm.stopListening()
//                    print("stoplistening() run in AllTaskView")
//                }
                
                Button(action: {
                    showAddTask.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                })
                .padding()
                .position(x: 350, y: 570)
                .sheet(isPresented: $showAddTask) {
                    AddTaskView()
                }
                
            }
    }
}

struct ShowAllTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllTasksView()
    }
}
