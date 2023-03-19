//
//  MoodInputCardView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 14/02/2023.
//

import SwiftUI

struct MoodInputCardView: View {
    @StateObject private var vm = AddMoodViewModelImp(
        service: AddMoodServiceImp()
    )
    @State private var mood = 5.0
    @State private var isEditing = false
    @EnvironmentObject var getVM: GetMoodViewModel
    
    @Binding var isMoodSelected: Bool
    var body: some View {
        VStack {
            Text("Rate your today's progress satisfaction 👀")
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
            VStack {
                    Text(emojiIdentifier(mood: mood))
                        .font(.system(size: 36))
                
                Text("\(mood, specifier: "%.1f")")
                    .foregroundColor(isEditing ? .blue : .black)
                    .font(.caption)
                Slider(
                    value: $mood,
                    in: 0...10,
                    step: 0.5,
                    onEditingChanged: { editing in
                        isEditing = editing
                    }
                )
                
            } //end vstack
            
            Button("Record") {
                getVM.moodStopListening()
                vm.mood = mood
                vm.addMood()
                isMoodSelected = false
                getVM.moodlistenDatabase()
            }
            .foregroundColor(.black)
            .cornerRadius(9)
            .buttonStyle(.bordered)
            .padding(.top, 1)
//            .offset(x: 0, y: -18)
            
        }//end vstack
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 10)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
    }//end view
}

func emojiIdentifier(mood: Double) -> String {
    if (mood == 0.0 || mood == 0.5){
        return MoodEmoji.zero.emoji
    } else if (mood == 1.0 || mood == 1.5){
        return MoodEmoji.one.emoji
    } else if (mood == 2.0 || mood == 2.5){
        return MoodEmoji.two.emoji
    } else if (mood == 3.0 || mood == 3.5){
        return MoodEmoji.three.emoji
    } else if (mood == 4.0 || mood == 4.5){
        return MoodEmoji.four.emoji
    } else if (mood == 5.0 || mood == 5.5){
        return MoodEmoji.five.emoji
    } else if (mood == 6.0 || mood == 6.5){
        return MoodEmoji.six.emoji
    } else if (mood == 7.0 || mood == 7.5){
        return MoodEmoji.seven.emoji
    } else if (mood == 8.0 || mood == 8.5){
        return MoodEmoji.eight.emoji
    } else if (mood == 9.0 || mood == 9.5){
        return MoodEmoji.nine.emoji
    } else if (mood == 10.0 || mood == 10.5){
        return MoodEmoji.ten.emoji
    }
    return "error"
}

struct MoodInputCardView_Previews: PreviewProvider {
    static var previews: some View {
        MoodInputCardView(isMoodSelected: .constant(false))
    }
}


//button
//HStack{
//    Button(action: {
//        vm.mood = 1
//        vm.addMood()
//        isMoodSelected = true
//    }, label: {
//        Text("😭")
//    })
//    .padding(5)
//
//    Button(action: {
//        vm.mood = 2
//        vm.addMood()
//        isMoodSelected = true
//    }, label: {
//        Text("😣")
//    })
//    .padding(5)
//
//    Button(action: {
//        vm.mood = 3
//        vm.addMood()
//        isMoodSelected = true
//    }, label: {
//        Text("🙁")
//    })
//    .padding(5)
//
//    Button(action: {
//        vm.mood = 4
//        vm.addMood()
//        isMoodSelected = true
//    }, label: {
//        Text("🙂")
//    })
//    .padding(5)
//
//    Button(action: {
//        vm.mood = 5
//        vm.addMood()
//        isMoodSelected = true
//    }, label: {
//        Text("😀")
//    })
//    .padding(5)
//
//    Button(action: {
//        vm.mood = 6
//        vm.addMood()
//        isMoodSelected = true
//    }, label: {
//        Text("🥳")
//    })
//    .padding(5)
//}// end hstack
