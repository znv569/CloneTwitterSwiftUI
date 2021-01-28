//
//  DetailTweet.swift
//  TwitterSiwftUI
//
//  Created by Admin on 14.01.2021.
//

import SwiftUI
import Kingfisher

struct DetailTweetView: View {
    @StateObject var viewModel: TweetViewModel
    
    init(_ tweet: Tweet){
        _viewModel = StateObject(wrappedValue: TweetViewModel(tweet))
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            
            ScrollView {
                HStack(alignment: .center){
                    KFImage(viewModel.tweet.user.profileImageUrl)
                        .resizable()
                        .frame(width: 42, height: 42, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .overlay(RoundedRectangle(cornerRadius: 32)
                                    .stroke(Color.blue, lineWidth: 0.4))
                        .shadow(color: Color.black.opacity(0.6), radius: 4)
                    VStack(alignment: .leading){
                        Text(viewModel.tweet.user.fullname)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        Text("@\(viewModel.tweet.user.username)")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
            
            
                Text(viewModel.tweet.caption)
                    .font(.system(size: 16))
                
                Text(viewModel.tweet.timestamp.fulltime)
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                Divider()
                
                HStack{
                    Text("0")
                        .font(.system(size: 15, weight: .bold))
                    Text("Retweets")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    Text("\(viewModel.tweet.likes)")
                        .font(.system(size: 15, weight: .bold))
                    Text("Likes")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                
                Divider()
                ActionTweetButtonView(viewModel: viewModel)
                Divider()
                ForEach(viewModel.replays){ tweet in
                    NavigationLink(
                        destination: NavigationLazyView( DetailTweetView(tweet) ),
                        label: {
                            TweetCell(tweet)
                        })
                    
                }
                
            }
            .padding()
            .onAppear{
                viewModel.fetchReplys()
            }
            .onDisappear{
                viewModel.stopListen()
            }
        }
    }
}

struct DetailTweetTweet_Previews: PreviewProvider {
    static var previews: some View {
        DetailTweetView(Tweet())
    }
}
