//
//  s4View.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 30/03/2023.
//

import SwiftUI

struct s4View: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    Image("bee")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150.0)
                    VStack(alignment: .leading){
                        Text("Procrastination has been denounced a student’s worst enemy. Probably everyone has tried to avoid some unpalatable task at some time - don't worry, it is a natural human reaction.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.bottom,6)
                    
                    VStack(alignment: .leading){
                        Text("💪 To overcome procastination:")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("⋅ Eliminate distractive environment")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Put a lock on social media")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Record down all tasks")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Try the Pomodoro technique")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Do something to get started")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Be kind to yourself")
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
                        Text("Small changes make a big difference. Try out the suggestions, it might help you approach your tasks with greater engagement and attention.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                        Text("Remember, overcoming procrastination is a journey that requires patience, persistence, and self-compassion. Don't forget to also take time for self-care and relaxation!🥰")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                    }
                    .padding(.top,6)
                    
                    VStack(alignment: .leading,spacing: 4){
                        Text("Read more from the sources:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[5 Research-Based Strategies for Overcoming Procrastination](https://hbr.org/2017/10/5-research-based-strategies-for-overcoming-procrastination)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[Advice on procrastination](https://www.qmul.ac.uk/welfare/wellbeing-support/wellbeing-resources/a-z-common-topics/procrastination/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                              
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[Battling with procrastination](https://info.lse.ac.uk/current-students/Assets/Articles/procrastination)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[Need Help Staying Focused? Try These 10 Tips](https://www.healthline.com/health/mental-health/how-to-stay-focused)")
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

struct s4View_Previews: PreviewProvider {
    static var previews: some View {
        s4View()
    }
}
