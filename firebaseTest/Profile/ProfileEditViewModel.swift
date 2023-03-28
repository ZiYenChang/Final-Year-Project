//
//  ProfileEditViewModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 28/03/2023.
//

import Foundation
import Combine
import Firebase
import FirebaseDatabase
import SwiftUI

struct ProfileModel: Codable, Equatable {
    var courseName: String
    var firstName: String
}

final class ProfileEditViewModel: ObservableObject {
    @Published var profile: ProfileModel = ProfileModel(courseName: "", firstName: "")
    
    private lazy var databasePath: DatabaseReference? = {
        let ref = Database.database().reference().child("users").child(self.uid)
        return ref
    }()
    
    private let decoder = JSONDecoder()
    
    private var uid:String = ""
    
    init(){
        let user = Auth.auth().currentUser
        if let user = user {
            uid = user.uid
        }
    }
    
    func listentoUserDatabase() {
        
        guard let databasePath = databasePath else {
            return
        }
        databasePath
            .observe(.value) { [weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String: Any]
                    
                else {
                    print("Nothing")
                    print(self!.uid)
                    return
                }
                
                json["id"] = snapshot.key
                do {
                    let userData = try JSONSerialization.data(withJSONObject: json)
                    let userDecoded = try self.decoder.decode(ProfileModel.self, from: userData)
                    self.profile = userDecoded
                } catch {
                    print("An error occurred", error)
                }
            }
        
        print("Called user Database")
    }

    
    func stopListeningUser() {
        databasePath?.removeAllObservers()
    }
    
    func updateName(){
        let values = [
            "courseName": profile.courseName,
            "firstName": profile.firstName
        ] as [String : Any]
        
        databasePath!
            .updateChildValues(values){ error, ref in
                if let err = error{
                    print("Failed due to error:", err)
                }else{
                    print("Name updated")
                }
            }
    }
}
