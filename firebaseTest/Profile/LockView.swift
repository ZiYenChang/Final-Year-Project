//
//  LockView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 29/03/2023.
//

import SwiftUI

struct LockView: View {
    @EnvironmentObject var securityController: SecurityController
        
        
        var body: some View {
            
            VStack(spacing: 5){
                Image(systemName: "lock.fill")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(12)
                Text("App Locked")
                    .font(.title)
                    .fontWeight(.semibold)
                Button("Unlock") {
                    securityController.authenticate()
                }
                .padding(5)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001) {
    //                    securityController.authenticate()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("sunrise-pastel")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.8)
            )
            
        }
}

//struct LockView_Previews: PreviewProvider {
//    static var previews: some View {
//        LockView()
//    }
//}
