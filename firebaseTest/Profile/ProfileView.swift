//
//  ProfileView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImp
//    @StateObject private var vm = SessionServiceViewModelImp(
//        service: SessionServiceImp()
//    )
//    @StateObject var vm: SessionServiceViewModelImp
    @StateObject private var vm = ProfileEditViewModel()
    @State private var editingName = false
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        VStack {
//            Text("Hi \(sessionService.userDetails?.firstName ?? " ")")
            Text("About you 😌")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .padding(.horizontal, 10)
                .fontWeight(.semibold)
            Divider()
            if !editingName{
                HStack{
                    Text(vm.profile.firstName)
                    
                    Spacer()
                    
                    Button(action: {
                        editingName.toggle()
                    }) {
                        Text("Edit")
                    }
                }
                .padding(.horizontal)
            } else{
                HStack{
                    TextField("Your name", text: $vm.profile.firstName)
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
                }
                .padding(.horizontal)
            }
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
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//            .environmentObject(SessionServiceImp())
//    }
//}
