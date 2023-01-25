//
//  SecureFieldView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import SwiftUI

struct SecureFieldView: View {
    
    @Binding var password: String
    let placeholder: String
    let sfSymbol: String?
    
    
    var body: some View {
        SecureField(placeholder, text: $password)
            .frame(maxWidth: .infinity,
                   minHeight: 50)
            .padding(.leading, sfSymbol == nil ? 14 : 38)
            .background(
                ZStack(alignment: .leading){
                    if let systemImage = sfSymbol {
                        Image(systemName: systemImage)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.leading, 10)
                            .foregroundColor(.gray.opacity(0.5))
                    }
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(.gray.opacity(0.25))
                }
            )
    }
}

struct SecureFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SecureFieldView(password: .constant(""), placeholder: "Password", sfSymbol: "lock")
    }
}
