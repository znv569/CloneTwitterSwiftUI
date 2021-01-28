//
//  SearchView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 29.12.2020.
//

import SwiftUI
import SwiftUIRefresh

struct SearchView: View {
    
    @ObservedObject var viewModel = SearchViewModel()
    @State var showRefresh = false
    
    var body: some View {
        VStack{
            SearchBar(text: $viewModel.searchText, placeholder: "Search user")
            
                
                ScrollView{
                    ForEach(viewModel.users) { user in
                        
                        NavigationLink(
                            destination: NavigationLazyView( UserProfileView(user)),
                            label: {
                                UserCell(user: user)
                            })
                        }
                }
              
                
        }
       .navigationTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
