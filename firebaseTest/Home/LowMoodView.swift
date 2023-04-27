//
//  LowMoodView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/03/2023.
//

import SwiftUI

struct LowMoodModel: Hashable, Identifiable {
    var title: String
    var id: Int
}

extension LowMoodModel {
    static let data: [LowMoodModel] =
    [
        LowMoodModel(title: "I am anxious about the deadlines 🗓️",
                     id: 1),
        LowMoodModel(title: "My tasks aren't progressing as expected 😥",
                     id: 2),
        LowMoodModel(title: "I can't see much progress. I feel overwhelmed 🧐",
                     id: 3),
        LowMoodModel(title: "I can't help but procrastinate🐢",
                     id: 4),
        LowMoodModel(title: "I find the tasks difficult 😵‍💫",
                     id: 5),
        LowMoodModel(title: "I think I need a break 🥱",
                     id: 6),
        LowMoodModel(title: "I don't feel motivated 😪",
                     id: 7)
    ]
}

struct LowMoodView: View {
    @State private var answerHasSelected: Bool = false
    @State private var selection: Int = 0
    let recentDeadline: Int
    let user: String
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-views-in-a-grid-using-lazyvgrid-and-lazyhgrid
    
    var body: some View {
        
        
        VStack {
            Text("\(user), you seems to be not satisfied with your current progress. What is bothering you? 🤔")
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .shadow(color: Color.black.opacity(0.2), radius: 4.5, x: 0, y: 0)
            
            LazyVGrid(columns: columns, spacing: 10) {
                if recentDeadline > 0{
                    Button(action: {
                        answerHasSelected = true
                        selection = LowMoodModel.data[0].id
                    }, label: {
                        Text(LowMoodModel.data[0].title)
                            .frame(maxWidth: .infinity)
                            .frame(height: 80)
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.vertical, 4)
                            .shadow(color: Color.black.opacity(0.1), radius: 4.0, x: 0, y: 0)
                        //                                .foregroundColor(.black)
                        
                    })
                    .background(.blue.opacity(0.25))
                    .cornerRadius(20)
                    .buttonStyle(.bordered)
                    .padding(.horizontal,1)
                    .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 0)
                }
                ForEach(0..<LowMoodModel.data.count-1, id: \.self) { i in
                    Button(action: {
                        answerHasSelected = true
                        selection = LowMoodModel.data[i+1].id
                    }, label: {
                        Text(LowMoodModel.data[i+1].title)
                            .frame(maxWidth: .infinity)
                            .frame(height: 80)
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.vertical, 4)
                            .shadow(color: Color.black.opacity(0.1), radius: 4.0, x: 0, y: 0)
                        
                    })
                    .background(.blue.opacity(0.25))
                    .cornerRadius(20)
                    .buttonStyle(.bordered)
                    .padding(.horizontal,1)
                    .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 0)
                }
                
                
            }
            .padding(.horizontal, 5)
            
        }
        .sheet(isPresented: $answerHasSelected,
               content: {
            if selection == 1{
                s1View()
            }else if selection == 2{
                s2View()
            }else if selection == 3{
                s3View()
            }else if selection == 4{
                s4View()
            }else if selection == 5{
                s5View()
            }else if selection == 6{
                s6View()
            }else if selection == 7{
                s7View()
            }
        })
        .padding()
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4.5, x: 0, y: 0)
        .animation(.easeInOut, value: answerHasSelected)
        
    }
}

struct LowMoodView_Previews: PreviewProvider {
    static var previews: some View {
        LowMoodView(recentDeadline: 1, user: "Jane")
    }
}
