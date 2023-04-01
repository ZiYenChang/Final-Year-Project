//
//  LowMoodView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/03/2023.
//

import SwiftUI

struct LowMoodView: View {
    @State private var answerHasSelected: Bool = false
    @State private var selection: Int = 0
    let recentDeadline: Int
    
    
    var body: some View {
        
        VStack {
                Text("You seems to be not satisfied with your current progress. What is bothering you?🤔")
                    .multilineTextAlignment(.center)
                
            if recentDeadline > 0{
                Button(action: {
                    answerHasSelected = true
                    selection = 1
                }, label: {
                    Text("I am anxious about the deadlines 🗓️")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
            }
                
                Button(action: {
                    answerHasSelected.toggle()
                    selection = 2
                }, label: {
                    Text("My tasks aren't progressing as expected 😥")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
                
                Button(action: {
                    answerHasSelected.toggle()
                    selection = 3
                }, label: {
                    Text("I feel overwhelmed with the tasks. I can't see my progress much 🧐")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
                
                Button(action: {
                    answerHasSelected.toggle()
                    selection = 4
                }, label: {
                    Text("I can't help but procastinate🐢")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
                
                Button(action: {
                    answerHasSelected.toggle()
                    selection = 5
                }, label: {
                    Text("I find the tasks difficult 😵‍💫")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
                
                Button(action: {
                    answerHasSelected.toggle()
                    selection = 6
                }, label: {
                    Text("I think I need a break 🥱")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
                
                Button(action: {
                    answerHasSelected.toggle()
                    selection = 7
                }, label: {
                    Text("I don't feel motivated 😪")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
            
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
        LowMoodView(recentDeadline: 1)
    }
}
