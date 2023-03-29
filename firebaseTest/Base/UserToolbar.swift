//
//  UserToolbar.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 09/02/2023.
//

import SwiftUI

struct UserToolbar: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var sessionService: SessionServiceImp
//    @StateObject var vm = SessionServiceImp()
    
    func body(content: Content) -> some View {
        content
            .navigationBarHidden(false)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView()
                        .environmentObject(sessionService))
                    {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.black.opacity(0.4))
                            .scaleEffect(1.2)
                    }
                    
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Welcome \(sessionService.userDetails?.firstName ?? " ")")
                        .font(.body)
                        .foregroundColor(.black.opacity(0.4))
                    
                }
            }
    }
}

extension View {
    func showUserToolbar() -> some View{
        self.modifier(UserToolbar())
    }
}
