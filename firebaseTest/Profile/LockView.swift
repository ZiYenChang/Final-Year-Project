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
            Button("Unlock") {
                securityController.authenticate()
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001) {
                    securityController.authenticate()
                }
            }
        }
}

//struct LockView_Previews: PreviewProvider {
//    static var previews: some View {
//        LockView()
//    }
//}
