//
//  s7View.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 30/03/2023.
//

import SwiftUI

struct s7View: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    Image("hug-smile")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 130.0)
                    VStack(alignment: .leading){
                        Text("There will be days where you're not motivated, but this is totally fine. It's good that you are acknowledging your resistance and difficult feelings with motivation 😉")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.bottom,6)
                    
                    VStack(alignment: .leading){
                        Text("🌈 When not feeling motivated:")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("⋅ Don't blame yourself")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Figure out your avoidance areas")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Set small, measurable goals")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Write things down")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Take small breaks")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Switch on some music")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Fuel yourself with some healthy food")
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
                        Text("You can try switching up your routine or studying environment to reinvigorate your focus. It's important to step out of your comfort zone. You might want to “gamify” a task to make it more interesting for you.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                        Text("If you need external help, try reaching out to get Queen Mary's [emotional and mental wellbeing support](https://www.qmul.ac.uk/welfare/wellbeing-support/) so you feel able to engage and enjoy your studies!")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                        Text("Remember to also take care of yourself. Keep pushing forward and trust in your ability to succeed! 🥰")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                    }
                    .padding(.top,6)
                    
                    VStack(alignment: .leading,spacing: 4){
                        Text("Read more from the sources:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[5 ways to increase your motivation](https://residentiallife.qmul.ac.uk/5-ways-to-increase-your-motivation_132343)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[10 ways to motivate yourself to study](https://www.ucl.ac.uk/news/2015/nov/10-ways-motivate-yourself-study)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                              
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[Tackling your to-do list](https://www.nhs.uk/every-mind-matters/mental-wellbeing-tips/self-help-cbt-techniques/tackling-your-to-do-list/)")
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

struct s7View_Previews: PreviewProvider {
    static var previews: some View {
        s7View()
    }
}
