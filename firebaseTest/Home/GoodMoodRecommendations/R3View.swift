//
//  R3View.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 06/04/2023.
//
//Breaking down tasks 🧱
import SwiftUI

struct R3View: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    Image("bee")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150.0)
                    VStack(alignment: .leading){
                        Text("When you are faced with a big task, it helps if you break the task down into smaller, manageable parts. This will help you avoid stress and procrastination.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack {
                        VStack(alignment: .leading){
                            Text("Ideas for breaking down tasks 💡")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            VStack(alignment: .leading){
                                Text("1. Look at the big picture")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.bottom,1)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("To better understand the direction you are heading, you should first understand what your end goal is. ")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.bottom,3)
                            }
                            VStack(alignment: .leading){
                                Text("2. Examine the parts of the task")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.bottom,1)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("List down all the necessary steps that you need to take to complete your task.")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.bottom,3)
                            }
                            VStack(alignment: .leading){
                                Text("3. Create a timeline for the tasks")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.bottom,1)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Identify what should you do first, second, third, etc. and consider the deadline for each of them.")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.bottom,3)
                            }
                            VStack(alignment: .leading){
                                Text("4. Have a plan to stay on track")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.bottom,1)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Put the time you will spend on the project into your schedule. Utilise the tasks section of this app to manage each tasks.")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.bottom,3)
                            }
                            VStack(alignment: .leading){
                                Text("5. Final review")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.bottom,1)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Complete your task early enough to have some time left for a peer or self review.")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.bottom,3)
                            }

                        }
                    }
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4.0, x: 0, y: 0)
                    
                    VStack(alignment: .leading){
                        Text("Breaking down tasks not only to help you complete them. More importantly, it’s about knowing how you can be more productive and use your time and energy wisely. ")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top,6)
                    
                    VStack {
                        VStack(alignment: .leading){
                            Text("Benefits of breaking down tasks 💛")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Improve your focus")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Give your mind a break")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Allow you to delegate")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Help you to set more specific goals")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Helps you identify whether a task is a priority")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                        }
                        
                        
                    }
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4.0, x: 0, y: 0)
                    
                    VStack(alignment: .leading){
                        Text("You might consider doing your hardest or most time-consuming tasks first. This is one strategy that may make you more likely to complete those tasks without procrastinating and help you boost productivity. This can also create a sense of accomplishment and a positive mood while you work on other tasks because you know that you already finished your hardest tasks.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top,6)
                    
                    
                    
                    VStack(alignment: .leading,spacing: 4){
                        Text("Read more from the sources:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[Break large tasks down into more manageable pieces](https://news.uga.edu/break-large-tasks-down-into-smaller-more-manageable-pieces/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[How to Break Down Tasks into Smaller Ones](https://kanbanzone.com/2021/how-to-break-down-tasks-into-smaller-ones/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[How To Break Down Tasks in 5 Steps (Plus Tips)](https://www.indeed.com/career-advice/career-development/how-to-break-down-tasks)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                             
                    }
                    .padding(.top,40)
                    
                }
                .font(.subheadline)
                .padding()
                .padding(.horizontal, 10)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .padding(8)
                                .font(.caption2)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray.opacity(0.6))
                                .background(
                                    .regularMaterial,
                                    in: Circle()
                                )
                        })
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Image("water-5")
                .resizable()
                .scaledToFill()
            .ignoresSafeArea())
        }
    }
}

struct R3View_Previews: PreviewProvider {
    static var previews: some View {
        R3View()
    }
}
