//
//  UserProfileView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 10.01.2021.
//

import SwiftUI

struct UserProfileView: View {
    
    @StateObject private var viewModel: ProfileViewModel
    
    
    init(_ user: User){
        _viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    var body: some View {
        
       
        
        VStack{
           ScrollView{
                ProfileHeaderView(viewModel: viewModel)
                    .padding(.top, 20)
            
                ForEach(viewModel.showTweets){ tweet in
                    TweetCell(tweet)
                }
           }
            
            
        }
        .navigationTitle(viewModel.user.username)
        .onDisappear{
            viewModel.stopObserve()
            viewModel.stopListerFirestore()
        }
        .onAppear{
            viewModel.startObserve()
            viewModel.changeView()
        }
       

    }
}

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//    }
//}
