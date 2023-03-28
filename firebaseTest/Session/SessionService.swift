//
//  SessionService.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Combine
import Foundation
import FirebaseAuth
import FirebaseDatabase

enum SessionState {
    case loggedIn
    case loggedOut
}

//protocol SessionService {
//    var state: SessionState { get }
//    var userDetails: SessionUserModel? { get } //optional because it will be nil until user logged in
//    func logout()
//    func updateFirstname()
//}

final class SessionServiceImp: ObservableObject{
    
    
    // use @Published to listen to changes. If there are changes, withdraw the view
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: SessionUserModel?
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init(){
        setupFirebaseAuthHandler()
    }
    
    func logout() {
        try? Auth.auth().signOut() //mark it as an optional try - if it fails then nothing happen(nil)
    }
    
    func updateFirstname(with details: SessionUserModel) -> AnyPublisher<Void, Error> {
        Deferred{
            Future{ promise in
                let user = Auth.auth().currentUser?.uid
                if let user = user {
                    let values = [
                        "firstName": details.firstName,
                        "courseName": details.courseName
                    ] as [String : Any]
                    
                    Database.database()
                        .reference()
                        .child("users")
                        .child(user)
                        .updateChildValues(values){ error, ref in
                            if let err = error{
                                promise(.failure (err))
                                print("Failed due to error:", err)
                            }
                            else{
                                print("Username Updated")
                                promise(.success(()))
                            }
                            
                        }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
}

//handle switching between login view and main view, and setting user details during login and logout
private extension SessionServiceImp{
    func setupFirebaseAuthHandler(){
        
        handler = Auth.auth() // assign handler
            .addStateDidChangeListener{[weak self] res, user in //user is the user object
                guard let self = self else {return} //get user
                self.state = user == nil ? .loggedOut : .loggedIn // if user object nil - loggedOut
                if let uid = user?.uid{
                    self.handlerRefresh(with: uid)
                }
                
            }
        
    }
    
    func handlerRefresh(with uid: String){
        Database.database()
            .reference()
            .child("users")
            .child(uid)
            .observe(.value) { [weak self] snapshot in
                
                guard let self=self,
                      let value = snapshot.value as? NSDictionary, // get the snapshot out of the dictionary
                      let firstName = value[RegisterKeys.firstName.rawValue] as? String,
                      let courseName = value[RegisterKeys.courseName.rawValue] as? String else{
                    return
                }
                
                let user = Auth.auth().currentUser
                if let user = user {
                    let uid = user.uid
                    //main thread
                    DispatchQueue.main.async {
                        //set the userDetails property so that the UI updates on the main thread
                        self.userDetails = SessionUserModel(firstName: firstName,
                                                            courseName: courseName,
                                                            uid: uid)
                    }
                }
            }
    }
}
