//
//  AddTaskView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vmShow: ShowAllTasksViewModel
    
    @StateObject private var vm = AddTaskViewModelImp(
        service: AddTaskServiceImp()
    )
    
    @State private var subtaskTitle: String = ""
    @State private var subtasks: [String] = []
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Title", text: $vm.details.title)
                    TextField("Priority", text: $vm.details.priority)
                    TaskStatusPickerView(selection: $vm.details.status)
                    TextField("Note", text: $vm.details.note, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                    HStack {
                        DatePicker(selection: $vm.details.deadline){
                            Text("Deadline")
                        }
                    }
                }
                Section{
                    ForEach(self.subtasks, id: \.self){ subtask in
                        HStack{
                            Text(subtask)
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
                                }
                        }
                    }.onDelete { indexSet in
                        subtasks.remove(atOffsets: indexSet)

                    }
                    HStack{
                        TextField("Subtask Title", text: $subtaskTitle)
                            .foregroundColor(.secondary)
                        Button{
                            self.subtasks.append(subtaskTitle)
                            subtaskTitle = ""
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }

                    }
                    
                }header: {
                    Text("Subtasks")
                }
                
            }
            .navigationTitle("New Task")
            .applyClose()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        vm.subtasks = subtasks
                        vm.addTask()
                        vmShow.listentoRealtimeDatabase()
                        print("listentoRealtimeDatabase() run in AddTaskView")
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Add")
                            .foregroundColor(.blue)
                    })
                }
            }
        }
        
    }
}

//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskView()
//    }
//}
