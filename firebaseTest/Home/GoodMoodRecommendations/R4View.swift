//
//  R4View.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 06/04/2023.
//
//Tips on preparing for exams

import SwiftUI

struct R4View: View {
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
                        Text("Being well prepared for your exams is the best way to overcome stress and anxiety, and gives you the best chance of getting good grades.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack {
                        VStack(alignment: .leading){
                            Text("Revision tips 💡")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Make a realistic revision schedule")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Find your own revision style")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Customise your notes to make them more personal")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Practice past exam paper")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Take regular short breaks")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Group study with friends")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Take regular short breaks")
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
                        Text("It is normal to have some level of stress throughout the duration of a degree programme. Note that the university provides various [support](https://www.qmul.ac.uk/advisorhub/academic-support/exam-stress/) to help you deal with exam stress.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("As a final tip, remember that being well hydrated is essential for your brain to work at its best. Make sure you keep drinking plenty of water throughout your revision, and also on the exam day. 🍀")
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
                            Text("[Tips on preparing for exams](https://www.nhs.uk/mental-health/children-and-young-adults/help-for-teenagers-young-adults-and-students/tips-on-preparing-for-exams/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[Exam Preparation: Ten Study Tips](https://www.topuniversities.com/student-info/health-and-support/exam-preparation-ten-study-tips)")
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

struct R4View_Previews: PreviewProvider {
    static var previews: some View {
        R4View()
    }
}
