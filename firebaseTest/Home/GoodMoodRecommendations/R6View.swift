//
//  R6View.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 06/04/2023.
//
//Eating a balance diet

import SwiftUI

struct R6View: View {
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
                        Text("Eating a healthy, balanced diet is an important part of maintaining good health, and can help you feel your best. ")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack {
                        VStack(alignment: .leading){
                            Text("😋 Healthy eating tips: ")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Eat at least 5 portions of a variety of fruit and vegetables every day ")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Drink lots of water")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Choose unsaturated oils and spreads, and eat them in small amounts")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Have some dairy or dairy alternatives")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Eat a good breakfast")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Limit your sugar intake")
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
                        Text("Eating healthily can be a challenge if you are shopping on a budget, but you can make your money go further and buy some lower-cost nutritious foods.🍲")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding(.top,6)
                    
                    VStack {
                        VStack(alignment: .leading){
                            Text("Eat affordably 🛒")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom,1)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Make a shopping list and stick to it")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Try the supermarket’s own brand or value brand products")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Batch cooking")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Cooking with your housemates")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.bottom,1)
                            HStack(alignment: .top) {
                                Text("⋅")
                                Text("Frozen fruit and veg can be cheaper than fresh")
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
                        Text("Eating a healthy diet can help you feel better, cope with stress and perform better.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Remember, it's not just about what you eat, but also how much and how often. With some effort and planning, eating healthily can be both affordable and enjoyable. 😜")
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
                            Text("[8 tips for healthy eating](https://www.nhs.uk/live-well/eat-well/how-to-eat-a-balanced-diet/eight-tips-for-healthy-eating/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[10 Healthy Eating Tips for Busy Students](https://clarke.edu/campus-life/health-wellness/counseling/articles-advice/10-healthy-eating-tips-for-the-busy-college-student/)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[A healthy and sustainable diet for the student budget](https://www.nutrition.org.uk/life-stages/students/)")
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

struct R6View_Previews: PreviewProvider {
    static var previews: some View {
        R6View()
    }
}
