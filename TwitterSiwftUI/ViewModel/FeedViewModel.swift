//
//  FeedViewModel.swift
//  TwitterSiwftUI
//
//  Created by Admin on 14.01.2021.
//

import SwiftUI
import Firebase





class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    

    
    
    private var listener: ListenerRegistration?
    
        init(){
            fetchTweets()
        }
    
    

    
    
       func fetchTweets(){
        HudShowing.shared.showHud(true)
            listener?.remove()
        
            listener = TweetService.shared.fetchTweets(compleation: { tweets in
                self.tweets = tweets
                HudShowing.shared.showHud(false)
            })
        }
    
    
    func removeObserve(){
        listener?.remove()
    }
    
}
