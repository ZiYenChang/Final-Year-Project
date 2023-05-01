//
//  RegisterView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import SwiftUI
import UserNotifications

struct RegisterView: View {
    
    @StateObject private var vm = RegisterViewModelImp(
        service: RegisterServiceImp()
    )
    @State private var confirmedPassword = ""
    @State private var termsAgreement: Bool = false
    @State private var viewTnC: Bool = false
    @State private var checkTnC: Bool = false
    
    var body: some View {
        NavigationView{
            VStack(spacing: 16){
                VStack(spacing: 10){
                    TextFieldView(text: $vm.userDetails.firstName,
                                  placeholder: "Preferred Username",
                                  keyboardType: .emailAddress,
                                  sfSymbol: nil)
                    TextFieldView(text: $vm.userDetails.courseName,
                                  placeholder: "Course Name",
                                  keyboardType: .emailAddress,
                                  sfSymbol: nil)
                    Divider()
                        .padding(.vertical, 5)
                        .opacity(0.8)
                    TextFieldView(text: $vm.userDetails.email,
                                  placeholder: "Email",
                                  keyboardType: .emailAddress,
                                  sfSymbol: "envelope")
                    SecureFieldView(password: $vm.userDetails.password,
                                    placeholder: "Password",
                                    sfSymbol: "lock")
                    SecureFieldView(password: $confirmedPassword,
                                    placeholder: "Comfirmed Password",
                                    sfSymbol: "lock")
                }
                .padding(.top)
                Toggle(isOn: $termsAgreement){
                    Button(action: {
                        viewTnC = true
                    }, label: {
                        Text("Terms and conditions")
                            .shadow(color: Color.black.opacity(0.1), radius: 4.0, x: 0, y: 0)
                            .foregroundColor(checkTnC == true ? .red : .blue)
                        
                    })
                    
                }
                .onChange(of: termsAgreement, perform: { value in
                    checkTnC = false
                })
                .padding(.horizontal)
                Spacer()
                VStack{
                    Button(action: {
                        if termsAgreement{
                            checkTnC = false
                            vm.register()
                            NotificationManager.instance.cancelNotification()
                            NotificationManager.instance.scheduleTimeNotification(title: "Welcome to Seed", subtitle: "Your task management companion", minutes: 15)
                            NotificationManager.instance.scheduleDateNotification(title: "How is your day?", subtitle: "Checkout your progress!", dateHour: 16, dateMinute: 00)
                        }
                        else{
                            checkTnC = true
                        }
                    }, label: {
                        Text("Register")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                    })
                    .padding(13)
                }
                .background(termsAgreement == true ? .blue : .blue.opacity(0.6))
                .cornerRadius(9)
                .padding(.horizontal)
                .padding(.bottom)
//                ButtonView(title: "Register") {
//                    if termsAgreement{
//                        vm.register()
//                    }
//                }
//                .padding(.bottom)
                
                
            }
            .sheet(isPresented: $viewTnC,
                   content: {
                RegisterTnCView()
                }
            )
            .padding(.horizontal)
            .navigationTitle("Register")
            .applyClose()
            .alert(isPresented: $vm.hasError,
                   content: {
                
                if case .failed(let error) = vm.state{ // access the enum to get the case out of the state
                    return Alert(title: Text("Error"),
                                 message: Text(error.localizedDescription))
                }else{ // if it can't cast the case for the state
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
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
