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
                .font(.system(size: 14, weight: .semibold))
                .sheet(isPresented: $showForgotPassword) {
                    ResetPasswordView()
                }
            }
            Spacer()
                VStack{
                    Button(action: {
                        vm.login()
                        NotificationManager.instance.cancelNotification()
                        NotificationManager.instance.scheduleDateNotification(title: "How is your day?", subtitle: "Checkout your progress!", dateHour: 15, dateMinute: 13)
                    }, label: {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                    })
                    .padding(16)
                }
                .background(.blue)
                .cornerRadius(9)
            
            VStack{
                Button(action: {
                    showRegister.toggle()
                }, label: {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.blue)
                })
                .sheet(isPresented: $showRegister) {
                    RegisterView()
                }
                .padding(13)
            }
            .background(.white.opacity(0.8))
            .cornerRadius(9)
            .padding(.bottom)
                
//                ButtonView(title: "Login") {
//                    vm.login()
//                }
//                ButtonView(title: "Register",bgColor: .clear, fgColor: .blue, borderColor: .blue) {
//                    showRegister.toggle()
//                }
//                .sheet(isPresented: $showRegister) {
//                    RegisterView()
//                }
//
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
        .background(Image("orange-green")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LoginView()
        }
    }
}
