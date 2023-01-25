//
//  CloseModifier.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import SwiftUI

struct CloseModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.blue)
                    })
                }
            }
    }
    
}

extension View {
    func applyClose() -> some View{
        self.modifier(CloseModifier())
    }
}
