//
//  MeditationVideoView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 09/03/2023.
//

import SwiftUI

struct MeditationVideoView: View {
    @ObservedObject var webViewModel = WebViewModel(url: "https://www.youtube.com/watch_popup?v=j734gLbQFbU")
    @Binding var isVideoDone: Bool
    
    var body: some View {
        
        VStack {
            if let ranInt = Int.random(in: 1..<4){
                if ranInt == 1{
                    Text("Good Morning! 🤩")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                } else if ranInt == 2{
                    Text("Wishing you the best for the day ahead😚")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                } else if ranInt == 3{
                    Text("Good day to you!")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                } else{
                    Text("Morning ☀️")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                }
            }
            if let ranInt = Int.random(in: 1..<2){
                if ranInt == 1{
                    Text("Have a short meditation to start your day🧘")
                        .font(.subheadline)
                } else {
                    Text("Start your day with a short meditation🧘")
                        .font(.subheadline)
                }
            }
            
            ZStack {
                WebViewContainer(webViewModel: webViewModel)
                if webViewModel.isLoading {
                    ProgressView()
                        .frame(height: 30)
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .frame(height: 180)
            Text("Source: \(webViewModel.title)")
                .font(.caption2)
                .foregroundColor(.secondary)
            
            HStack (spacing: 40){
                Button("Change Video", role: .none) {
                    //
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                Button("Done", role: .cancel) {
                    isVideoDone = true
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4.5, x: 0, y: 0)    }
}

struct MeditationVideoView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationVideoView(isVideoDone: .constant(false))
    }
}
