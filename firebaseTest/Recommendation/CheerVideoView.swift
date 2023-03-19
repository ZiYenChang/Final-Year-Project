//
//  CheerVideoView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 09/03/2023.
//

import SwiftUI
import WebKit

struct CheerVideoView: View {
    @State var messageID: Int = 1
    @ObservedObject var webViewModel = WebViewModel(url: "https://www.youtube.com/watch_popup?v=07d2dXHYb94")
    
    var body: some View {
        
        VStack {
            if messageID == 1{
                Text("Seems like you wasn't too happy about your progress yesterday. Why not take a break and watch this short video to cheer up 😚")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
            } else if messageID == 2{
                Text("Feeling stressed is perfectly reasonable and rational, so try not to beat yourself up on top of what you’re already going through. 😚")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
            } else if messageID == 3{
                Text("Feeling like this doesn’t mean you’re failing; it’s just part of the journey. You’re going to have ups and downs, and that’s okay.")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
            } else if messageID == 4{
                Text("It’s totally understandable to feel overwhelmed. It doesn’t make it any easier, but please know that you are not alone.")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
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
                    //
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

struct CheerVideoView_Previews: PreviewProvider {
    static var previews: some View {
        CheerVideoView()
    }
}
