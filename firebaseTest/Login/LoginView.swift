//
//  LoginView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var showRegister = false
    @State private var showForgotPassword = false
    
    @StateObject private var vm = LoginViewModelImp(
        service: LoginServiceImp()
    )
    
    var body: some View {
        VStack(spacing: 16){
            Spacer()
            VStack(spacing: 10){
                TextFieldView(text: $vm.details.email,
                              placeholder: "Email",
                              keyboardType: .emailAddress,
                              sfSymbol: "envelope")
                SecureFieldView(password: $vm.details.password,
                                placeholder: "Password",
                                sfSymbol: "lock")
            }
            HStack{
                Button(action: {
                    showForgotPassword.toggle()
                }, label: {
                    Text("Forgot Password?")
                })
                .font(.system(size: 14, weight: .bold))
                .sheet(isPresented: $showForgotPassword) {
                    ResetPasswordView()
                }
            }
            Spacer()
            VStack(spacing: 12){
                ButtonView(title: "Login") {
                    vm.login()
                }
                ButtonView(title: "Register",bgColor: .clear, fgColor: .blue, borderColor: .blue) {
                    showRegister.toggle()
                }
                .sheet(isPresented: $showRegister) {
                    RegisterView()
                }
            }
            .padding(.bottom)
            
        }
        .padding(.horizontal)
        .navigationTitle("Login")
        .alert(isPresented: $vm.hasError,
               content: {
            
                if case .failed(let error) = vm.state{ // access the enum to get the case out of the state
                    return Alert(title: Text("Error"),
                                 message: Text(error.localizedDescription))
                }else{ // if it can't cast the case for the sate
                    return Alert(title: Text("Error"),
                                 message: Text("Something went wrong. Pleasse try again"))
                }
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LoginView()
        }
    }
}
