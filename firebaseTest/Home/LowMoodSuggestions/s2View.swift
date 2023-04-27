//
//  s2View.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 30/03/2023.
//

import SwiftUI

struct s2View: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    Image("rabbit-hug")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150.0)
                    Text("Disappointment is a natural reaction when things don’t go as intended.")
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom,6)
                    
                    VStack(alignment: .leading){
                        Text("🕊️ When things don’t go as planned:")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("⋅ Hold space for emotions that arise")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,8)
                        Text("⋅ Take a minute for yourself")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,8)
                        Text("⋅ Practice self-compassion")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,8)
                        Text("⋅ Know that perfection ≠ accomplishment")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,8)
                        Text("⋅ Work on flexibility")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,8)
                        Text("⋅ Recalibrate your expectations")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,8)
                        Text("⋅ Seek out others for support")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,1)
                            .padding(.leading,8)
                    }
                    .padding()
                    .background(.thickMaterial)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4.0, x: 0, y: 0)
                    .padding(.horizontal,5)
                    
                    VStack(alignment: .leading){
                        Text("Try not to automatically think the worst is going to occur. Different does not necessarily mean bad. Sometimes, the unexpected can be a pleasant surprise! 💝")
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom,3)
                        Text("Remember that life goes up and down, and it's normal to feel disappointment or frustration. So, keep an open mind and embrace the journey! 🛣️")
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom,3)
                    }
                    .padding(.top,6)
                    
                    VStack(alignment: .leading,spacing: 4){
                        Text("Read more from the sources:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[How to Cope When Things Don't Go as Planned](https://www.verywellmind.com/coping-when-things-dont-go-as-planned-6833036)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[What to do when things don’t turn out the way you planned](https://psychcentral.com/blog/when-things-dont-turn-out-how-youd-hoped-expected-or-planned)")
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        HStack(alignment: .top) {
                            Text("⋅")
                            Text("[5 Ways To Stay Calm When Things Don’t Go As Planned](https://www.forbes.com/sites/averyblank/2022/02/08/5-ways-to-stay-calm-when-things-dont-go-as-planned/)")
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
            .background(Image("water-3")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
        }
    }
}

struct s2View_Previews: PreviewProvider {
    static var previews: some View {
        s2View()
    }
}
