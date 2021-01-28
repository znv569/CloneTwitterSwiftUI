//
//  ActionTweetButtonView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 14.01.2021.
//

import SwiftUI

struct ActionTweetButtonView: View {
    
   @ObservedObject var viewModel: TweetViewModel
    @State var showReplyTweet: Bool = false
    
    var body: some View {
        HStack{
            Button(action: {
                self.showReplyTweet.toggle()
            }, label: {
                Image(systemName: "bubble.left")
                   
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            })
            .fullScreenCover(isPresented: $showReplyTweet, content: {
                NewTweetView(isPresented: $showReplyTweet, tweet: viewModel.tweet)
            })
         
            Spacer()
     
            
            Button(action: {
               
            }, label: {
                Image(systemName: "arrow.2.squarepath")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            })
            
            
       
            Spacer()
            
            Button(action: {
                viewModel.handleLike()
            }, label: {
                Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
                    .foregroundColor(viewModel.isLiked ? Color.red : Color.gray)
            })
 
           Spacer()
            
            Button(action: {}, label: {
                Image(systemName: "bookmark")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            })
         
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(Color(.darkGray))
        .padding(.horizontal)
    }
}

struct ActionTweetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ActionTweetButtonView(viewModel: TweetViewModel(Tweet()))
    }
}
