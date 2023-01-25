//
//  ResetPasswordView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import SwiftUI

struct ResetPasswordView: View {
    @StateObject private var vm = ResetPasswordViewModelImp(
        service: ResetPasswordServiceImp()
    )
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView{
            VStack(spacing: 16){
                TextFieldView(text: $vm.email,
                              placeholder: "Email",
                              keyboardType: .emailAddress,
                              sfSymbol: "envelope")
                
                ButtonView(title: "Register") {
                    vm.resetPassword()
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.bottom)
                
                
            }
            .padding(.horizontal)
            .navigationTitle("Reset Password")
            .applyClose()
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
