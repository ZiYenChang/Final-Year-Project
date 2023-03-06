//
//  ShowTaskView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI
import Foundation

struct ShowTaskCardView: View {
    let task: TaskModel
    @ObservedObject var vm: ShowAllTasksViewModel
    var body: some View {
        HStack{
            ZStack{
                if(completedPercentage()[1] > 0){
                    Circle()
                        .stroke(lineWidth: 5)
                        .frame(width: 35, height: 35)
                        .foregroundColor(task.status.accentColor)
                        .opacity(0.5)
                        .padding(.vertical, 6)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(completedPercentage()[2]))
                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                        .foregroundColor(task.status.accentColor)
                        .frame(width: 35, height: 35)
                        .rotationEffect(Angle(degrees: 270.0))
                    
                    Text("\(Int(completedPercentage()[0]))/\(Int(completedPercentage()[1]))")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .opacity(0.8)
                }else{
                    Circle()
                        .stroke(lineWidth: 5)
                        .frame(width: 35, height: 35)
                        .foregroundColor(task.status.accentColor)
                        .opacity(0.7)
                        .padding(.vertical, 6)
                }
                
                
            }// end zstack
            
            VStack(alignment: .leading, spacing: 5){
                Text(task.title)
                    .font(.headline)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
            }
            .padding(5)
            
            VStack{
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.gray)
                        .opacity(0.2)
                    Text(numberOfDaysBetween(to: task.deadline))
                        .padding(.vertical, 3)
                        .padding(.horizontal, 5)
                        .font(.caption)
                }
                .foregroundColor(.black)
                .frame(minWidth: 35)
                .fixedSize(horizontal: true, vertical: true)
                
                Spacer()
            }// end vstack
            
        }
    }// end view
    func completedPercentage() -> [Float] {
        var totalTask: Float = 0
        var completedTask: Float = 0
        for subtask in vm.subtasks{
            if(subtask.taskid == task.id){
                totalTask = totalTask + 1
                if(subtask.completed){
                    completedTask =  completedTask + 1
                }
            }
        }
        
        let completedPercentage = completedTask/totalTask
        
        return [completedTask, totalTask, completedPercentage]
    }
}

func numberOfDaysBetween(to: Date) -> String {
    let today = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    let todayString = dateFormatter.string(from: today)
    
    let numberOfDays = Calendar.current.dateComponents([.day], from: dateFormatter.date(from: todayString)!, to: to)
    if (to < dateFormatter.date(from: todayString)!){
        return "Overdue"
    }else if (numberOfDays.day! > 0){
        return "\(numberOfDays.day!)d"
    }
    return "Due today"
}


//struct ShowTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowTaskCardView(task: TaskModel.sampleData[0], vm:vm)
//    }
//}
