//
//  NewMessageView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 08.01.2021.
//

import SwiftUI

struct NewMessageView: View {
    @State var searchText = ""
    @Binding var show: Bool

    
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        ScrollView{
            SearchBar(text: $searchText, placeholder: "Search user")
            VStack{
                
                ForEach(viewModel.users) { user in
                  
                    UserCellNewChatView(user: user)
                   
                }
            }
           
        }
        .navigationTitle("Search")
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(show: .constant(false))
    }
}
