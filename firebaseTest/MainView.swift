//
//  MainView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI

enum tabs: String, CaseIterable, Identifiable {
    case tasks
    case home
    case mood
    var id: Self { self }
    
    var text: String {
        switch self {
        case .tasks: return "Tasks"
        case .home: return "Home"
        case .mood: return "Mood"
        }
    }
}

struct MainView: View {
    @State var selection = tabs.home
    
    var body: some View {
        TabView(selection: $selection){
            ShowAllTasksView()
                .tabItem {
                    Label("Tasks", systemImage: "mappin")
                }.tag(tabs.tasks)
            HomeView(tabSelection: $selection)
                .tabItem {
                    Label("Home", systemImage: "house")
                }.tag(tabs.home)
            MoodView()
                .tabItem {
                    Label("Mood", systemImage: "face.smiling")
                }.tag(tabs.mood)
        }
        .accentColor(.blue)
        .navigationTitle(selection.text)
        .showUserToolbar()
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(SessionServiceImp())
    }
}
