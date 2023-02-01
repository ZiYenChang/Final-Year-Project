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
    
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Task Info")) {
                    TextField("Title", text: $vm.details.title)
                    TextField("Priority", text: $vm.details.priority)
                    TaskStatusPickerView(selection: $vm.details.status)
                    TextField("Note", text: $vm.details.note, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }
                
            }
            .navigationTitle("Edit Task")
            .applyClose()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        vm.updateTask()
                        presentationMode.wrappedValue.dismiss()
                        showTaskvm.listentoRealtimeDatabase()
                        print("listentoRealtimeDatabase() run in UpdateTaskView")
                    }, label: {
                        Text("Update")
                            .foregroundColor(.blue)
                    })
                }
            }
        }
    }
}

//struct UpdateTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateTaskView(vm:UpdateTaskViewModelImp(
//            service: UpdateTaskServiceImp(),
//            details: TaskModel.sampleData[0])
//        )
//    }
//}
