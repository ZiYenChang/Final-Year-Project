//
//  SessionUserModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Foundation

struct SessionUserModel{
    //use let instead of var
    //because it's not something that we want to change or bind
    //just show the current info
    let firstName: String
    let courseName: String
    let uid: String
}

//create service to handle the firebase auth listener
//to know if someone is login/logout
