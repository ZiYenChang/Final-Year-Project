//
//  MainView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI

struct MainView: View {
    @State var selection = 2
    
    var body: some View {
        TabView(selection: $selection){
            ShowAllTasksView()
                .tabItem {
                    Label("Tasks", systemImage: "mappin")
                }.tag(1)
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }.tag(2)
        }
        .accentColor(.purple)
        .navigationTitle(selection == 1 ? "Tasks" : "Home")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(SessionServiceImp())
    }
}
