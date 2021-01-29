//
//  NewMessageView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 08.01.2021.
//

import SwiftUI

struct NewMessageView: View {
    
    @Binding var show: Bool
    @ObservedObject var viewModel = SearchViewModel()
    
    
    init(show: Binding<Bool>)
    {
        self._show = show
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().isOpaque = true
        UINavigationBar.appearance().barStyle = .default
        print("main")
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                SearchBar(text: $viewModel.searchText, placeholder: "Search user")
                VStack{
                    
                    ForEach(viewModel.users) { user in
                      
                        UserCellNewChatView(user: user)
                       
                    }
                }
               
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
       
            .navigationBarItems(trailing: Button(action: {
                show.toggle()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 27, height: 27, alignment: .center)
                    .foregroundColor(Color(UIColor.black.withAlphaComponent(0.75)))
            }))
        }
       
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(show: .constant(false))
    }
}
