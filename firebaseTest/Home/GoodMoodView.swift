//
//  GoodMoodView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 05/04/2023.
//

import SwiftUI

struct GoodMoodModel: Hashable, Identifiable {
    var title: String
    var id: Int
}

extension GoodMoodModel {
    static let data: [LowMoodModel] =
    [
        LowMoodModel(title: "Making your university experience even better 🏫",
                     id: 1),
        LowMoodModel(title: "Understand and manage stress 🤝",
                     id: 2),
        LowMoodModel(title: "Breaking down tasks 🧱",
                     id: 3),
        LowMoodModel(title: "Tips on preparing for exams 📝",
                     id: 4),
        LowMoodModel(title: "Benefits of mindfulness 🕊️",
                     id: 5),
        LowMoodModel(title: "Eating a balance diet 🥙",
                     id: 6)
    ]
}

struct GoodMoodView: View {
    @State private var answerHasSelected: Bool = false
    @State private var selection: Int = 0
    let user: String
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack {
            Text("\(user), here's some tips for you! 😎")
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .shadow(color: Color.black.opacity(0.2), radius: 4.5, x: 0, y: 0)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<GoodMoodModel.data.count, id: \.self) { i in
                    Button(action: {
                        answerHasSelected = true
                        selection = GoodMoodModel.data[i].id
                    }, label: {
                        Text(GoodMoodModel.data[i].title)
                            .frame(maxWidth: .infinity)
                            .frame(height: 80)
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.vertical, 4)
                            .shadow(color: Color.black.opacity(0.1), radius: 4.0, x: 0, y: 0)
                        
                    })
                    .background(.pink.opacity(0.2))
                    .cornerRadius(20)
                    .buttonStyle(.bordered)
                    .padding(.horizontal,1)
                    .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 0)
                }
                
                
            }
            .padding(.horizontal, 5)
            
        }
        .sheet(isPresented: $answerHasSelected,
               content: {
            if selection == 1{
                R1View()
            }else if selection == 2{
                R2View()
            }else if selection == 3{
                R3View()
            }else if selection == 4{
                R4View()
            }else if selection == 5{
                R5View()
            }else if selection == 6{
                R6View()
            }
        })
        .padding()
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4.5, x: 0, y: 0)
        .animation(.easeInOut, value: answerHasSelected)
    }
}

struct GoodMoodView_Previews: PreviewProvider {
    static var previews: some View {
        GoodMoodView(user:"Jane")
    }
}
