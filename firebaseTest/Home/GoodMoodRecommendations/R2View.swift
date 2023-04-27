//
//  R2View.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 06/04/2023.
//
//Understand and manage stress 🤝

import SwiftUI

struct R2View: View {
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
                        Text("University can be a stressful experience, as well as being fun and exciting. You may feel stressed about starting university, exams, coursework deadlines, living with people you do not know, or thinking about the future.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack {
                        VStack(alignment: .leading){
                            Text("Signs you might be stressed 🪧")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Feel irritable or anxious")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Feel like you cannot enjoy yourself")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Worried a lot of the time")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Find it hard to concentrate")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Feel short of breath or breathe very fast")
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
                        Text("Studying can be demanding and it is natural to feel anxious about this. The good news is there are lots of things that can help.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top,6)
                    
                    VStack {
                        VStack(alignment: .leading){
                            Text("Ways to support yourself 💛")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Process your feelings – work out what it is that's making you feel stressed. See if you can change your circumstances to ease the pressure.")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Respond to your body’s experience of stress. Practise [breathing techniques](https://www.nhs.uk/mental-health/self-help/guides-tools-and-activities/breathing-exercises-for-stress/), do soothing activities, exercise or go for a walk in the fresh air.")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Try to have a healthy lifestyle. Eat well, get enough sleep, be physically active, cut down on alcohol, and take time to relax as well as working and studying.")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Reach out for support – talk to a friend, tutor or someone in your family about your stress. It can help you to feel some relief. It may be helpful to talk to your GP if you’re feeling very anxious.")
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
                        Text("You may want to consider getting help for stress if you're struggling to cope with stress, things you're trying yourself are not helping or stress is affecting your life or university work.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top,6)
                    
                    VStack {
                        VStack(alignment: .leading){
                            Text("More information ℹ️")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Recommendations for therapeutic books: [Bibliotherapy book list](https://www.qmul.ac.uk/welfare/wellbeing-support/wellbeing-resources/bibliotherapy-list/)")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Specialist organisations: [Anxiety UK](https://www.anxietyuk.org.uk) and [MIND](https://www.mind.org.uk/information-support/types-of-mental-health-problems/anxiety-and-panic-attacks/about-anxiety/%C2%A0/)")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("[Tips on beating stress](https://www.nhs.uk/mental-health/self-help/guides-tools-and-activities/tips-to-reduce-stress/)")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("[Mental wellbeing audio guides](https://www.nhs.uk/mental-health/self-help/guides-tools-and-activities/mental-wellbeing-audio-guides/)")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                        }
                        
                        
                    }
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4.0, x: 0, y: 0)
                    
                    
                    VStack(alignment: .leading,spacing: 4){
                        Text("Read more from the sources:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[Student stress](https://www.nhs.uk/mental-health/children-and-young-adults/help-for-teenagers-young-adults-and-students/student-stress-self-help-tips/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[Anxiety](https://www.qmul.ac.uk/welfare/wellbeing-support/wellbeing-resources/a-z-common-topics/anxiety/)")
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

struct R2View_Previews: PreviewProvider {
    static var previews: some View {
        R2View()
    }
}
