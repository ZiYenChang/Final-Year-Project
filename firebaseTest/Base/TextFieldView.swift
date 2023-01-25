//
//  TextFieldView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    
    var body: some View {
        TextField(placeholder, text: $text)
            .frame(maxWidth: .infinity,
                   minHeight: 50)
            .padding(.leading, sfSymbol == nil ? 14 : 38)
            .keyboardType(keyboardType)
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

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextFieldView(text:.constant(""),
                          placeholder: "hello",
                          keyboardType: .emailAddress,
                          sfSymbol: "envelope")
            TextFieldView(text:.constant(""),
                          placeholder: "hello",
                          keyboardType: .emailAddress,
                          sfSymbol: nil)
        }
        
    }
}
