//
//  LoginDetailsModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Foundation

struct LoginDetailsModel{
    //use var because need to use them in view model to bind the input to the struct
    var email: String
    var password: String
}

extension LoginDetailsModel{
    
    //use static so don't need to initialise it
    static var new: LoginDetailsModel{
        
        LoginDetailsModel(email: "",
                          password: "")
    }
}

