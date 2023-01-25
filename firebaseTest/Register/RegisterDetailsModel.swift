//
//  RegisterDetailsModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Foundation

struct RegisterDetailsModel {
    var email: String
    var password: String
    var firstName: String
    var courseName: String
}

//an extension for new empty details, so that don't need to retype the parameters
extension RegisterDetailsModel{
    
    //use static so don't need to initialise it
    static var new: RegisterDetailsModel{
        
        RegisterDetailsModel(email: "",
                             password: "",
                             firstName: "",
                             courseName: "")
    }
}
