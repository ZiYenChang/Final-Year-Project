//
//  SessionUserModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Foundation

struct SessionUserModel: Decodable, Equatable{
    //use let instead of var
    //because it's not something that we want to change or bind
    //just show the current info
    var firstName: String
    var courseName: String
    var uid: String
}

//create service to handle the firebase auth listener
//to know if someone is login/logout

extension SessionUserModel{
    //use static so don't need to initialise it
    static var new: SessionUserModel{
        
        return SessionUserModel(
            firstName: "",
            courseName: "",
            uid: ""
        )
    }
}
