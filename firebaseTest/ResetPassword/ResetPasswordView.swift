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
            ScrollView{
                VStack(spacing: 16){
                    TextFieldView(text: $vm.email,
                                  placeholder: "Email",
                                  keyboardType: .emailAddress,
                                  sfSymbol: "envelope")
                    
                    VStack{
                        Button(action: {
                            vm.resetPassword()
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Reset")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.blue)
                        })
                        .padding(13)
                    }
                    .background(.white.opacity(0.8))
                    .cornerRadius(9)
                    .padding(.top, 5)
                    
                }
                .padding(.horizontal)
                .padding(.top, 200)
            }
            .navigationTitle("Reset Password")
            .applyClose()
            .scrollContentBackground(.hidden)
            .background(Image("orange-green")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
            
        }
        
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
