//
//  s5View.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 30/03/2023.
//

import SwiftUI

struct s5View: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    Image("fox-jump")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150.0)
                    VStack(alignment: .leading){
                        Text("Don't worry, you are not alone. Many students find the their university work difficult too. ")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.bottom,6)
                    
                    VStack(alignment: .leading){
                        Text("🤺 Tips on handling task obstacles:")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("⋅ Utilise Internet and modern tools")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Actively participate in lessons")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Don’t be afraid to seek help")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Work with your peers")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Post questions on study forums")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,10)
                        Text("⋅ Overcome the fear of failure")
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
                        Text("Being uncomfortable allows for growth. Perhaps utilise the module forum on [QMPlus](https://qmplus.qmul.ac.uk) to ask for support, or reach out to the module organiser to get advise.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                        Text("Besides, find out more about the [academic support](https://www.qmul.ac.uk/library/academic-skills/) available at Queen Mary. The [Revise Well](https://www.qmul.ac.uk/library/old-academic-skills/revise-well/) page also includes a variety of resources to support you in achieving the best you can!")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                        Text("Remember, facing difficult tasks can be challenging, but it's important to approach them with a positive mindset. So, stay motivated - you are capable of achieving great things!🥰")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                    }
                    .padding(.top,6)
                    
                    VStack(alignment: .leading,spacing: 4){
                        Text("Read more from the sources:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[Your Guide to Conquering College Coursework](https://summer.harvard.edu/blog/your-guide-to-conquering-college-coursework/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[How College Students Are Addressing Their Difficult Coursework?](https://www.theacademicpapers.co.uk/blog/2020/04/15/how-college-students-are-addressing-their-difficult-coursework/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                              
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[6 Ways to Handle the Obstacles when Writing a Coursework](https://medium.com/@amberdrey9/6-ways-to-handle-the-obstacles-when-writing-a-coursework-e32d17f65a7d)")
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
            .background(Image("water-7")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
        }
    }
}

struct s5View_Previews: PreviewProvider {
    static var previews: some View {
        s5View()
    }
}
