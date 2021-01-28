//
//  ContentView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 28.12.2020.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        Group{
            if viewModel.currentUser != nil {
                
                
                TabView{
                    NavigationView{
                    FeedView()
                        
                        .navigationBarTitleDisplayMode(.inline)
                    }.tabItem {
                        Image(systemName: "house")
                        Text("Home ")
                    }
                    NavigationView{
                        SearchView()
                            
                            .navigationBarTitleDisplayMode(.inline)
                    }.tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    NavigationView{
                        ConversationView()
                            
                        .navigationBarTitleDisplayMode(.inline)
                    }.tabItem {
                        Image(systemName: "envelope")
                        Text("Messages")
                    }
                }
                .ignoresSafeArea()
            }else{
                LoginView()
            }
        }
            
            
           
          
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
