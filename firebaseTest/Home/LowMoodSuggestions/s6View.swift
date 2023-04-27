//
//  s6View.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 30/03/2023.
//

import SwiftUI

struct s6View: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    Image("luggage-weather")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130.0)
                    VStack(alignment: .leading){
                        Text("You are doing well on addressing this! It may be time to take a step back and slow down when you feel burnout. ")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.bottom,6)
                    
                    VStack(alignment: .leading){
                        Text("⚡️ Stress busters:")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("⋅ Have some 'me time'")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Be physically active")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Look for the positives in life")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Work smarter, not harder")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Connect with other people")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Take control to feel more empowered")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Pay attention to the present moment")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                    }
                    .padding()
                    .background(.thickMaterial)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4.0, x: 0, y: 0)
                    .padding(.horizontal,12)
                    
                    VStack(alignment: .leading){
                        Text("When you decided to rest, it is crucial not to feel guilty. Removing yourself from work for a while can benefit your health and studies!")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                        Text("If you are struggling with your current situation and need a longer time to complete your coursework, you might want to consider to apply for [extenuating circumstances](https://www.qmul.ac.uk/student-experience/student-wellbeing-hub/extenuating-circumstances-a-guide-for-students/).")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                        Text("Be kind to yourself, take breaks when you need them, and remember that your well-being matters! 🥰")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                    }
                    .padding(.top,6)
                    
                    VStack(alignment: .leading,spacing: 4){
                        Text("Read more from the sources:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[5 steps to mental wellbeing](https://www.nhs.uk/mental-health/self-help/guides-tools-and-activities/five-steps-to-mental-wellbeing/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[10 stress busters](https://www.nhs.uk/mental-health/self-help/guides-tools-and-activities/tips-to-reduce-stress/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                              
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[5 benefits of taking breaks](https://www.ucl.ac.uk/students/news/2020/feb/5-benefits-taking-breaks)")
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
            .background(Image("water-6")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
        }
    }
}

struct s6View_Previews: PreviewProvider {
    static var previews: some View {
        s6View()
    }
}
