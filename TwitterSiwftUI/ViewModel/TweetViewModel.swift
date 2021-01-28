//
//  TweetViewModel.swift
//  TwitterSiwftUI
//
//  Created by Admin on 14.01.2021.
//

import SwiftUI
import Firebase

class TweetViewModel: ObservableObject {
    
    @Published var isLiked = false
    @Published var tweet: Tweet
    @Published var replays = [Tweet]()
    @Published var listener: ListenerRegistration?

    
    
    init(_ tweet: Tweet, loadReplays: Bool = false){
        self.tweet = tweet
        checkLike()
    }
    
    func handleLike(){
        if isLiked {
            TweetService.shared.unlikeTweet(tweet) {
                self.isLiked = false
            }
        }else{
            TweetService.shared.likeTweet(tweet) {
                self.isLiked = true
            }
        }
    }
    
    
    
    func fetchReplys(){
        listener?.remove()
        listener = TweetService.shared.fetchTweets(nil, tweet.ref) { tweets in
            self.replays = tweets
        }
    }
    
    
    func stopListen(){
        listener?.remove()
    }
  
    
    func checkLike(){
        TweetService.shared.checkLike(tweet) { result in
            self.isLiked = result
        }
    }
    
    
}
