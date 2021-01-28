//
//  UploadTweetViewModel.swift
//  TwitterSiwftUI
//
//  Created by Admin on 14.01.2021.
//

import Foundation



class UploadTweetViewModel: ObservableObject {
    
    let user: User
    let tweet: Tweet?
    
    
    init(_ user: User, tweet: Tweet? = nil){
        self.user = user
        self.tweet = tweet
    }
    
    
    
    
    func uploadTweet(_ caption: String, compleation: @escaping()->Void){
        TweetService.shared.uploadTweet(caption, tweet: tweet) {
            compleation()
        }
    }
    
}
