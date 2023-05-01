//
//  RegisterTnCView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 29/04/2023.
//

import SwiftUI

struct RegisterTnCView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8){
                Text("Please read carefully before using the App.")
                Text("By using the App, you consent to us collecting and using technical information about the Devices and related software, hardware and peripherals for Services that are internet-based or wireless to improve our products and to provide any Service(s) to you. You consent the collection of your task progress satisfaction, to identify if you are experiencing low mood or possibly mental illness and provide suggestions")
                Text("The App may contain links to other independent third-party websites (Third-party Sites). Third-party Sites are not under our control, and we are not responsible for and do not endorse their content or their privacy policies (if any). You will need to make your own independent judgement regarding your interaction with any Third-party Sites, including the purchase and use of any products or services accessible through them.")
                Text("The content in the App is provided for general information only. Please note that the App shall not be construed as a medical tool of any sort. It is not intended to amount to advice on which you should rely. If you have any questions or concerns about the content within the App we recommend you seek professional or specialist advice before taking, or refraining from, any action on the basis of the content of the App.")
                Spacer()
            }
            .navigationTitle("Terms and Conditions")
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .padding(8)
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray.opacity(0.6))
                            .background(
                                .regularMaterial,
                                in: Circle()
                            )
                    })
                }
            }
        }
    }
}

struct RegisterTnCView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterTnCView()
    }
}
