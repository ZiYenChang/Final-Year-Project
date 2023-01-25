//
//  ButtonView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import SwiftUI

struct ButtonView: View {
    
    //Make the purpose of closure more clear
    typealias ActionHandler = () -> Void
    
    let title: String
    let bgColor: Color
    let fgColor: Color
    let borderColor: Color
    let handler: ActionHandler //Action assigned to button
    
    //To add default values
    internal init(title: String,
                  bgColor: Color = .blue,
                  fgColor: Color = .white,
                  borderColor: Color = .clear,
                  handler: @escaping ButtonView.ActionHandler) {
        self.title = title
        self.bgColor = bgColor
        self.fgColor = fgColor
        self.borderColor = borderColor
        self.handler = handler
    }
     
    var body: some View {
        Button(action: handler, label: {
            Text(title)
                .frame(maxWidth: .infinity,
                       maxHeight: 50)
        })
        .background(bgColor)
        .foregroundColor(fgColor)
        .font(.system(size: 18, weight: .semibold))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(borderColor, lineWidth: 2)
        )
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Login"){ }
    }
}
