//
//  AddTaskView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var vm = AddTaskViewModelImp(
        service: AddTaskServiceImp()
    )
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Title", text: $vm.details.title)
                    TextField("Priority", text: $vm.details.priority)
                    TaskStatusPickerView(selection: $vm.details.status)
                    TextField("Note", text: $vm.details.note, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
//                    HStack {
//                        DatePicker(selection: $vm.details.deadline){
//                            Text("Deadline")
//                        }
//                    }
                }
                
            }
            .navigationTitle("New Task")
            .applyClose()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        vm.addTask()
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

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
