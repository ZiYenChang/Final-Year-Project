//
//  ProfileView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var securityController:SecurityController
    
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var sessionService: SessionServiceImp

    @StateObject private var vm = ProfileEditViewModel()
    @State private var editingName = false
    @FocusState private var keyboardFocused: Bool
    @State private var showForgotPassword = false
    
    var body: some View {
        
            VStack {
                VStack{
                    HStack{
                        if !editingName{
                            Text(vm.profile.firstName)
                                .padding(.horizontal)
                            Spacer()
                            Button(action: {
                                editingName.toggle()
                            }) {
                                Text("Edit")
                                    .padding(.trailing,8)
                            }
                            .padding()
                            
                        }
                        else{
                            TextField("Your name", text: $vm.profile.firstName)
                                .padding(.horizontal)
                                .foregroundColor(.gray)
                                .focused($keyboardFocused)
                                .onAppear{
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        keyboardFocused = true
                                    }
                                }
                            
                            Button(action: {
                                vm.updateName()
                                editingName.toggle()
                                keyboardFocused = false
                                vm.listentoUserDatabase()
                            }) {
                                Text("Done")
                                    .padding(.trailing,8)
                            }
                            .padding()
                        }
                    }
                    .padding(.horizontal)
                    .background(.white.opacity(0.8))
                    .cornerRadius(9)
                    
                    HStack{
                        Text(vm.profile.email)
                            .padding()
                        Spacer()
                    }
                    .padding(.horizontal)
                    .background(.white.opacity(0.8))
                    .cornerRadius(9)

                    HStack{
                        Text("You are studying \(vm.profile.courseName) 🫡")
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    }
                    .padding(.horizontal)
                    .background(.white.opacity(0.8))
                    .cornerRadius(9)
                    
                    HStack{
                        Text("SECURITY AND PASSWORD")
                            .font(.caption)
                            .padding(.top,30)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .padding(.leading,22)
                        Spacer()
                    }
                    
                    Toggle("Screen Lock", isOn: $securityController.isAppLockEnabled)
                        .onChange(of: securityController.isAppLockEnabled, perform: { value in
                            securityController.appLockStateChange(value)
                            print("the value \(value)")
                        })
                        .padding(.horizontal,30)
                        .padding(.vertical,10)
                        .background(.white.opacity(0.8))
                        .cornerRadius(9)
                    HStack{
                        Text("Require Face ID to unlock App.")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.leading,30)
                        Spacer()
                    }
                    HStack{
                        Button(action: {
                            showForgotPassword.toggle()
                        }, label: {
                            Text("Reset Password")
                                .frame(maxWidth: .infinity)
                        })
                        .sheet(isPresented: $showForgotPassword) {
                            ResetPasswordView()
                        }
                        .padding(13)
                    }
                    .padding(.horizontal)
                    .background(.white.opacity(0.8))
                    .cornerRadius(9)
                    .padding(.top, 4)
                }
                .padding()
                
                Spacer()
//                ButtonView(title: "Logout") {
//                    sessionService.logout()
//                }
                VStack{
                    Button(action: {
                        sessionService.logout()
                    }, label: {
                        Text("Logout")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.red)
                            .padding()
                    })
                }
                .background(.white.opacity(0.8))
                .cornerRadius(9)
                .padding()
                
            }
            .onAppear{
                vm.listentoUserDatabase()
            }
            .onDisappear{
                vm.stopListeningUser()
            }
            .navigationTitle("About you")
            .scrollContentBackground(.hidden)
            .background(Image("orange-green")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
        
        
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//            .environmentObject(SessionServiceImp())
//    }
//}
