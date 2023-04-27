//
//  R1View.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 05/04/2023.
//

//Make your university experience better
import SwiftUI

struct R1View: View {
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
                        Text("Your university years can be some of the best years of your life. Here are some of the ways to make the most of your time at university!")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack {
                        VStack(alignment: .leading){
                            Text("1. Embrace learning 📖")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("It’s quite easy to become so distracted by deadlines, exams and the other chaos that you forget why you’re there in the first place - to LEARN!")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,3)
                        }
                        
                        VStack(alignment: .leading){
                            Text("2. Build new friendships 🧑‍🤝‍🧑")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("One of the best things about university is that it puts you in contact with so many new people. Try to meet people from outside your course as well! ")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,3)
                        }
                        
                        VStack(alignment: .leading){
                            Text("3. Join a society (or start one!) 🧱")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Make used of the opportunities to meet new people outside your course and accommodation, by joining a new group or attending Student Union's events!")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,3)
                        }
                        
                        VStack(alignment: .leading){
                            Text("4. Go to careers fairs 🧑‍💼")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("It can be easy to focus on just getting your degree rather than what you’ll do afterwards, but it's well worth getting experience before you embark on a career! ")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,3)
                        }
                        VStack(alignment: .leading){
                            Text("5. Get to know your lecturers 🧑‍🏫")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Getting to know your lecturers means that you might feel comfortable asking for more feedback on an essay, getting their recommendations for further study, and ultimately asking them for a reference when you apply for a job! ")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,3)
                        }
                    }
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4.0, x: 0, y: 0)
                    
                    VStack(alignment: .leading){
                        Text("One of the best things about university is that it gives you the opportunity to try new things and, at the end of the day, you can’t really know how bad something will be unless you try it.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Also, A lot of students underestimate the different pressures and stresses that they might experience during their time at university – so it’s important to be kind to yourself and take care of yourself! 🥰")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                    }
                    .padding(.top,6)
                    
                    VStack(alignment: .leading,spacing: 4){
                        Text("Read more from the sources:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[7 Ways to Make the Most of Your Time at Uni](https://unihub.mdx.ac.uk/student-life/news/lifestyle/7-ways-to-make-the-most-of-your-time-at-university)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[How to make the most of university: 14 tips from a graduate](https://targetjobs.co.uk/careers-advice/university-life/how-make-most-university-14-tips-graduate)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                              
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[7 Ways to Make Your University Experience Even Better](https://www.oxford-royale.com/articles/7-ways-university-experience-better/)")
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

struct R1View_Previews: PreviewProvider {
    static var previews: some View {
        R1View()
    }
}
