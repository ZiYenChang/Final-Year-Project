//
//  LockAppView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 08/02/2023.
//

import SwiftUI

struct LockAppView: View {
    @ObservedObject var appContext: LockAppViewModel

        var body: some View {
            VStack(spacing: 24) {
                Image(systemName: "faceid")
                    .resizable()
                    .frame(width: 150, height: 150)
                
                
                Button(action: {
                    appContext.requestBiometricUnlock()
                }, label: {
                    HStack {
                        Spacer()
                        Text("Login now")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                })
            }
            .padding()
        }
}

//struct LockAppView_Previews: PreviewProvider {
//    @State var appUnlocked = false
//    static var previews: some View {
//        LockAppView(appUnlocked: $appUnlocked)
//    }
//}
