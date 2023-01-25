//
//  RegisterView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var vm = RegisterViewModelImp(
        service: RegisterServiceImp()
    )
    
    var body: some View {
        NavigationView{
            VStack(spacing: 16){
                VStack(spacing: 10){
                    TextFieldView(text: $vm.userDetails.firstName,
                                  placeholder: "First Name",
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
                    SecureFieldView(password: .constant(""),
                                    placeholder: "Comfirmed Password",
                                    sfSymbol: "lock")
                }
                .padding(.top)
                Spacer()
                ButtonView(title: "Register") {
                    vm.register()
                }
                .padding(.bottom)
                
                
            }
            .padding(.horizontal)
            .navigationTitle("Register")
            .applyClose()
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
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
