//
//  s1View.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 30/03/2023.
//

import SwiftUI

struct s1View: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    Image("cat-liedown")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100.0)
                    VStack(alignment: .leading){
                        Text("Multiple looming deadlines can be daunting. Everyone deals with stress differently, so take time to find methods that work for you.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.bottom,6)
                    
                    VStack(alignment: .leading){
                        Text("💡 Top tips on handling with this stress:")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("⋅ Know your work style")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Prioritise your tasks")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Manage other people’s expectations")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Celebrate mini accomplishments")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Remember your previous successes")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Get a workout in")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Relax and stay calm")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Seek help when needed (Tell someone)")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                    }
                    .padding()
                    .background(.thickMaterial)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4.0, x: 0, y: 0)
                    .padding(.horizontal,8)
                    
                    VStack(alignment: .leading){
                        Text("Try to calm yourself mentally or do meditation. 🧘 Once you have calmed yourself, visualise the road map of how you will tackle this problem. This can show how the situation will be controlled and how success will be achieved.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                        Text("Besides, reframe stress as anticipation and excitement. It makes the tasks associated with the deadline much easier and more satisfying.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                        Text("Remember, you are capable of overcoming any challenge that comes your way. Take one step at a time, and don't forget to take breaks along the way. Good luck!🍀")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                    }
                    .padding(.top,6)
                    
                    VStack(alignment: .leading,spacing: 4){
                        Text("Read more from the sources:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[10 tips to cope with stressful deadlines](https://www.bbc.co.uk/programmes/articles/3CmYfYVYhCz5fPwdSRzL36N/10-tips-to-cope-with-stressful-deadlines)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[15 Recommendations For Handling Deadline Stress](https://www.forbes.com/sites/forbesbusinesscouncil/2019/12/17/15-recommendations-for-handling-deadline-stress/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[How to make deadlines motivating, not stressful](https://www.bbc.com/worklife/article/20200409-how-to-make-deadlines-motivating-not-stressful)")
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

struct s1View_Previews: PreviewProvider {
    static var previews: some View {
        s1View()
    }
}
