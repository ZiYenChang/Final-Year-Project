//
//  UpdateTaskView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI

struct UpdateTaskView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm: UpdateTaskViewModelImp
    @ObservedObject var showTaskvm: ShowAllTasksViewModel
    
    @State private var subtaskTitle: String = ""
    @State private var subtasks: [SubtaskModel] = []
    @State private var firstLoad = true
//    @State private var sub = self.vm.subtasks
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Task Info")) {
                    TextField("Title", text: $vm.details.title)
                    TextField("Priority", text: $vm.details.priority)
                    TaskStatusPickerView(selection: $vm.details.status)
                    HStack {
                        DatePicker(selection: $vm.details.deadline){
                            Text("Deadline")
                        }
                    }
                    TextField("Note", text: $vm.details.note, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }//section end
                
                Section{
                    if (subtasks == []){
                        ForEach(vm.subtasks){ subtask in
                            if(subtask.taskid == vm.details.id){
                                HStack{
                                    Text(subtask.title)
                                        .fontWeight(.medium)
                                    Spacer()
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            if let index = subtasks.firstIndex(of: subtask) {
                                                withAnimation {
                                                    subtasks.remove(at: index)
                                                }
                                            }
                                                vm.subID = subtask.id ?? ""
                                            if (vm.subID != ""){
                                                vm.deleteSubtask()
                                                showTaskvm.listentoRealtimeDatabase()
                                            }
                                        }
                                }//end hstack
                                .onAppear{
                                    if (firstLoad){
                                        subtasks.append(subtask)
                                        print(subtask)
                                    }
                                    
                                } // end onAppear
                            } //end if
                        } // end foreach
                        .onAppear {
                                    // Wait for a second
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        // After the wait, change the variable to false
                                        firstLoad = false
                                    }
                                }
                    } else{
                        ForEach(subtasks, id: \.self){ sub in
                            HStack{
                                Text(sub.title)
                                    .fontWeight(.medium)
                                Spacer()
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .onTapGesture {
//                                        vm.subID = sub.id
                                        if let index = subtasks.firstIndex(of: sub) {
                                            withAnimation {
                                                subtasks.remove(at: index)
                                            }
                                        }
                                            vm.subID = sub.id ?? ""
                                        if (vm.subID != ""){
                                            vm.deleteSubtask()
                                            showTaskvm.listentoRealtimeDatabase()
                                        }
                                    }
                            } //end hstack
                        } //end foreach
                    }
                    HStack{
                        TextField("Subtask Title", text: $subtaskTitle)
                            .foregroundColor(.secondary)
                        Button{
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "HH:mm E, d MMM y"
                            subtasks.append(SubtaskModel(title: subtaskTitle,
                                                         completed: false,
                                                         lastUpdate: dateFormatter.string(from: Date())
                                                        ))
                            subtaskTitle = ""
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }

                    }//end hstack
                }header: {
                    Text("Subtasks")
                }
            }//end form
            .navigationTitle("Edit Task")
            .applyClose()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        firstLoad = true
                        vm.subtasks = subtasks
                        vm.updateTask()
                        presentationMode.wrappedValue.dismiss()
                        showTaskvm.stopListening()
//                        showTaskvm.listentoRealtimeDatabase()
//                        print("listentoRealtimeDatabase() run in UpdateTaskView")
                    }, label: {
                        Text("Update")
                            .foregroundColor(.blue)
                    })
                }
            }//end toolbar
        }// end navigationview
    }// end body view
    
    private func stopLoadOnAppear(){
        firstLoad = false
        print("I'm in stop load")
    }
}// end view

//struct UpdateTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateTaskView(vm:UpdateTaskViewModelImp(
//            service: UpdateTaskServiceImp(),
//            details: TaskModel.sampleData[0])
//        )
//    }
//}
