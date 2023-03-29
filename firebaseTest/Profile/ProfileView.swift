//
//  ProfileView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var securityController = SecurityController()
    
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var sessionService: SessionServiceImp

    @StateObject private var vm = ProfileEditViewModel()
    @State private var editingName = false
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        
            VStack {
                ScrollView{
                    //            Text("Hi \(sessionService.userDetails?.firstName ?? " ")")
                    Text("About you")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .padding(.horizontal)
                        .fontWeight(.semibold)
                    
                    HStack{
                        if !editingName{
                            Text(vm.profile.firstName)
                                .padding(.horizontal)
                            Spacer()
                            Button(action: {
                                editingName.toggle()
                            }) {
                                Text("Edit")
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
                        Text("You are doing \(vm.profile.courseName) 🫡")
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    }
                    .padding(.horizontal)
                    .background(.white.opacity(0.8))
                    .cornerRadius(9)
                    
                    Toggle("App Lock", isOn: $securityController.isAppLockEnabled)
                        .onChange(of: securityController.isAppLockEnabled, perform: { value in
                            securityController.appLockStateChange(value)
                            print("the value \(value)")
                        })
                        .padding()
                }
                .padding()
                
                Spacer()
                ButtonView(title: "Logout") {
                    sessionService.logout()
                }
                .padding()
                
            }
            .onAppear{
                vm.listentoUserDatabase()
            }
            .onDisappear{
                vm.stopListeningUser()
            }
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
