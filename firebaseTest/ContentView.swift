//
//  ContentView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 17/01/2023.
//

import SwiftUI
import Firebase
let lightGreyColor = Color(red: 242.0/255.0, green: 242.0/255.0, blue: 247.0/255.0, opacity: 1.0)

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var newEmail: String = ""
    @State private var newPassword1: String = ""
    @State private var newPassword2: String = ""
    @State private var termsAgreement: Bool = false
    
    @State private var submitEmptyLogin: Bool = false
    @State private var submitEmptyCredentials: Bool = false
    @State private var submitDifferentPassword: Bool = false
    @State private var submitUncheckedTerms: Bool = false
    @State private var submitWrongEmail: Bool = false
    @State private var submitShortPassword: Bool = false
    
    @State private var showLogin: Bool = true
    @State private var isLoggedin: Bool = false
    
    var body: some View {
        
        if isLoggedin{
            AuthView()
        }
        else{
            auth
        }
        
    }
    
    var auth: some View {
        
        NavigationView{
            VStack{
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
                    .padding(.top, 50)
                
                Picker("", selection: $showLogin) {
                    Text("Log In")
                        .tag(true)
                    Text("Create Account")
                        .tag(false)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                if(showLogin){
                    TextField("QM Email", text: $email)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(8)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding(.horizontal)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    if(submitEmptyLogin == true){
                        Text("Please fill in all fields.")
                            .foregroundColor(.red)
                            .padding(.horizontal)
                            .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                self.submitWrongEmail.toggle()
                                            }
                                        }
                    }
                }
                else{
                    TextField("QM Email", text: $newEmail)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(8)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding(.horizontal)
                    
                    SecureField("Password", text: $newPassword1)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    SecureField("Confirmed Password", text: $newPassword2)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(8)
                        .border(submitDifferentPassword == true ? .red : .clear)
                        .padding(.horizontal)
                    
                    if(submitEmptyCredentials == true){
                        Text("Please fill in all fields.")
                            .foregroundColor(.red)
                            .padding(.horizontal)
                            .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                self.submitEmptyCredentials.toggle()
                                            }
                                        }
                    }
                    else if(submitDifferentPassword == true && showLogin == false){
                        Text("Please enter the same password")
                            .foregroundColor(.red)
                            .padding(.horizontal)
                            .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                self.submitEmptyCredentials.toggle()
                                            }
                                        }
                    }
                    else if(submitShortPassword == true && showLogin == false){
                        Text("Password must be at least 6 characters")
                            .foregroundColor(.red)
                            .padding(.horizontal)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    self.submitShortPassword.toggle()
                                }
                            }
                    }
                    else if(submitWrongEmail == true && showLogin == false){
                        Text("Please enter an email with @qmul.ac.uk")
                            .foregroundColor(.red)
                            .padding(.horizontal)
                            .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                self.submitWrongEmail.toggle()
                                            }
                                        }
                    }
                }
                
                
                
                Spacer()
                switch showLogin{
                case false:
                    Toggle(isOn: $termsAgreement){
                        Text("Agree to terms and conditions")
                    }
                    .padding(.bottom)
                    .padding(.horizontal, 30)
                    .foregroundColor(submitUncheckedTerms == true ? .red : .black)
                    
                    Button(action: {
                        submitEmptyCredentials = false
                        submitUncheckedTerms = false
                        submitWrongEmail = false
                        submitDifferentPassword = false
                        submitShortPassword = false
                        if (newEmail == "" || newPassword1 == "" || newPassword2 == ""){
                            submitEmptyCredentials = true
                        }
                        else if(!isValidEmail(newEmail)){
                            submitEmptyCredentials = false
                            submitWrongEmail = true
                        }
                        else if(newPassword1 != newPassword2){
                            submitEmptyCredentials = false
                            submitWrongEmail = false
                            submitDifferentPassword = true
                        }
                        else if(!isPasswordLong(newPassword1)){
                            submitEmptyCredentials = false
                            submitWrongEmail = false
                            submitDifferentPassword = false
                            submitShortPassword = true
                        }
                        else if(!termsAgreement){
                            submitEmptyCredentials = false
                            submitDifferentPassword = false
                            submitWrongEmail = false
                            submitShortPassword = false
                            submitUncheckedTerms = true
                        }
                        else{
                            submitEmptyCredentials = false
                            submitUncheckedTerms = false
                            submitWrongEmail = false
                            submitDifferentPassword = false
                            submitShortPassword = false
                                createUser()
                        }
                        
                    }, label: {
                        Text("Create Account")
                            .frame(width: 310, height: 45, alignment: .center)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.bottom)
                    })
                case true:
                    Button(action: {
                        if (email != "" || password != ""){
                            submitEmptyLogin = false
                            loginUser()
                        }else{
                            submitEmptyLogin = true
                        }
                        
                    }, label: {
                        Text("Log In")
                            .foregroundColor(.white)
                            .frame(width: 310, height: 45, alignment: .center)
                            .background(.blue)
                            .cornerRadius(8)
                            .padding(.bottom)
                    })
                }
                
                
                
            }
        }
    }
    private func createUser() {
        Auth.auth().createUser(withEmail: newEmail, password: newPassword1, completion: { result, err in
            if let err = err {
                print("Failed due to error:", err)
                return
            }
            print("Successfully created account with ID: \(result?.user.uid ?? "")")
            isLoggedin = true
        })
    }
    private func loginUser() {
          Auth.auth().signIn(withEmail: email, password: password) { result, err in
              if let err = err {
                  print("Failed due to error:", err)
                  return
              }
              print("Successfully logged in with ID: \(result?.user.uid ?? "")")
              //isAuthenticated = true
                isLoggedin = true
          }
      }
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?" + "@qmul.ac.uk"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: email)
    }
    
    private func isPasswordLong(_ password: String) -> Bool {
        let length = password.count
        if length<6 {
            return false
        }
        else{
            return true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
