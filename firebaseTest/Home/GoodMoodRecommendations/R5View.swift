//
//  R5View.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 06/04/2023.
//
//Benefits of mindfulness

import SwiftUI

struct R5View: View {
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
                        Text("Mindfulness involves paying more attention to the present moment – to your own thoughts and feelings, and to the world around you. This can improve your mental wellbeing.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack {
                        VStack(alignment: .leading){
                            Text("Why mindfulness? 🧠")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Become more self-aware")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Feel calmer and less stressed")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Help dealing issues more productively")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Notice signs of stress or anxiety earlier")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Cope with difficult or unhelpful thoughts")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Help you be kinder towards yourself")
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
                        Text("It is understandable to want to stop thinking about difficult things, but trying to get rid of upsetting thoughts sometimes make us think about them even more. The theory behind mindfulness is that by using [various techniques](https://www.mind.org.uk/information-support/drugs-and-treatments/mindfulness/mindfulness-exercises-tips/) to bring your attention to the present.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding(.top,6)
                    
                    VStack {
                        VStack(alignment: .leading){
                            Text("🙏 How to be more mindful:")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Notice the everyday regularly")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Try something new")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Be aware and accepting your thoughts")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Free yourself from the past and future")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Mindful meditation")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Focus on your breathing")
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
                        Text("Although anyone can try it, being mindful isn't always easy to do. It can take practice, and might not be right for everyone.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("To understand more about mindfulness, treach more from the source websites and articles!🧑‍💻")
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
                            Text("[NHS Mindfulness](https://www.nhs.uk/mental-health/self-help/tips-and-support/mindfulness/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[MIND Mindfulness](https://www.mind.org.uk/information-support/drugs-and-treatments/mindfulness/about-mindfulness/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[MAYO CLINIC Mindfulness exercises](https://www.mayoclinic.org/healthy-lifestyle/consumer-health/in-depth/mindfulness-exercises/art-20046356)")
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

struct R5View_Previews: PreviewProvider {
    static var previews: some View {
        R5View()
    }
}
