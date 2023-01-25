//
//  ProfileView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImp
    
    var body: some View {
        VStack {
            Text("Hi \(sessionService.userDetails?.firstName ?? " ")")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .padding(.horizontal, 10)
            Spacer()
            ButtonView(title: "Logout") {
                sessionService.logout()
            }
            .padding()
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(SessionServiceImp())
    }
}
