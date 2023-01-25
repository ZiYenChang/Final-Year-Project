//
//  HomeView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import SwiftUI

struct HomeView: View {
    //use to inject service into homeview
    //so that we can get user session detail and assign user details, and handle logout
    //Environment object passes data between parent(app) and child(home) view
    @EnvironmentObject var sessionService: SessionServiceImp
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAddTask = false
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Welcome \(sessionService.userDetails?.firstName ?? " ")")
                Text("You are studying \(sessionService.userDetails?.courseName ?? " ").")
                Spacer()
            }
            
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: ProfileView().environmentObject(sessionService))
                {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.gray.opacity(0.7))
                        .scaleEffect(1.2)
//                        .padding(.trailing)
                }
                
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Welcome \(sessionService.userDetails?.firstName ?? " ")")
                    .font(.body)
                    .foregroundColor(Color(.systemGray))
                
            }
        }
    
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .environmentObject(SessionServiceImp())
                .navigationTitle("Home")
        }
    }
}
