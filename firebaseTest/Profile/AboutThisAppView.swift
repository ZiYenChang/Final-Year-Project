//
//  AboutThisAppView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 06/04/2023.
//

import SwiftUI

struct AboutThisAppView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Thank you for using this App")
                Text("This is an app created by Zi Yen Chang.")
                    .padding(.bottom)
                
                Text("For any queries or feedback, please send an email to z.chang@se19.qmul.ac.uk")
                    .multilineTextAlignment(.center)
            }
            .padding()
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

struct AboutThisAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutThisAppView()
    }
}
