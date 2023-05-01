//
//  MainView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import SwiftUI
import UserNotifications

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
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var sessionService: SessionServiceImp
    @ObservedObject var securityController:SecurityController
    
    var body: some View {
        TabView(selection: $selection){
            ShowAllTasksView()
                .tabItem {
                    
                }.tag(tabs.tasks)
            HomeView(tabSelection: $selection)
                .tabItem {
                    
                }.tag(tabs.home)
            MoodView()
                .tabItem {
                    
                }.tag(tabs.mood)
        }
        .overlay( // Overlay the custom TabView component here
            Color.white
                .background(.thinMaterial) // Base color for Tab Bar
                .edgesIgnoringSafeArea(.vertical)
                .opacity(0.9)
                .frame(height: 50) // Match Height of native bar
                .overlay(HStack {
                    Spacer()
                    
                    // First Tab Button
                    Button(action: {
                        self.selection = tabs.tasks
                    }, label: {
                        VStack(alignment: .center, spacing:2){
                            Image(systemName: "lightbulb.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 23, height: 23, alignment: .center)
                                .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                                .opacity(selection == tabs.tasks ? 1 : 0.4)
                            Text("Task")
                                .font(.caption2)
                                .fontWeight(.medium)
                                .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                                .opacity(selection == tabs.tasks ? 1 : 0.4)
                        }
                        .padding(.trailing, 40)
                        .padding(.top, 5)
                        
                    })
                    Spacer()
                    
                    // Second Tab Button
                    Button(action: {
                        self.selection = tabs.home
                    }, label: {
                        VStack(alignment: .center, spacing:2){
                            Image(systemName: "house.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                                .opacity(selection == tabs.home ? 1 : 0.4)
                            Text("Home")
                                .font(.caption2)
                                .fontWeight(.medium)
                                .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                                .opacity(selection == tabs.home ? 1 : 0.4)
                        }
                        .padding(.top, 5)
                    })
                    
                    Spacer()
                    
                    // Third Tab Button
                    Button(action: {
                        self.selection = tabs.mood
                    }, label: {
                        VStack(alignment: .center, spacing:2){
                            Image(systemName: "heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                                .opacity(selection == tabs.mood ? 1 : 0.4)
                                
                            Text("Feel")
                                .font(.caption2)
                                .fontWeight(.medium)
                                .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                                .opacity(selection == tabs.mood ? 1 : 0.4)
                        }
                        .padding(.leading, 40)
                        .padding(.top, 5)
                        
                    })
                    Spacer()
                    
                })
        ,alignment: .bottom)
        .accentColor(.blue)
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        .navigationTitle(selection.text)
        .navigationBarHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: ProfileView(securityController: securityController)
                    .environmentObject(sessionService))
                {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.black.opacity(0.4))
                        .scaleEffect(1.2)
                }
                
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Welcome, \(sessionService.userDetails?.firstName ?? " ")")
                    .font(.body)
                    .foregroundColor(.black.opacity(0.4))
                
            }
        }
        
        
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//            .environmentObject(SessionServiceImp())
//    }
//}
