//
//  ProfileViewModel.swift
//  TwitterSiwftUI
//
//  Created by Admin on 12.01.2021.
//

import SwiftUI
import Firebase
import Combine

class ProfileViewModel: ObservableObject {
    
    
    var user: User
    @Published var isFollowed: Bool? = nil
    @Published var followers: Int = 0
    @Published var following: Int = 0
    
    @Published var showTweets = [Tweet]()
    var optionFilter: FiltersButtonOptions = .tweets{
        didSet{changeView()}
    }
    
    
    private var listener: ListenerRegistration?
    private var canceller: AnyCancellable?
    
    
    init(user: User){
        self.user = user
        self.fetchData()
        self.startObserve()
        print("init")
    }
    
    deinit{
        print("Deinit")
    }
    
    
    func startObserve(){
        stopObserve()
        
        self.canceller = self.user.objectWillChange.sink(receiveValue: { _ in
            self.objectWillChange.send()
        })
        
 
    }
    
    
    func changeView(){
        
        self.showTweets = [Tweet]()
        stopListerFirestore()
        
        switch optionFilter {
        
        case .tweets:
            fetchTweets()
        case .replies:
          fetchRelays()
        case .likes:
           fetchLikesTweets()
        }
    }
    
    func fetchRelays(){
        HudShowing.shared.showHud(true)
        
        listener = TweetService.shared.fetchLikeReplyUserTweets(user.id, type: .reply) { (tweets) in
            HudShowing.shared.showHud(false)
            self.showTweets = tweets
        }
    }
    
    func fetchTweets(){
        HudShowing.shared.showHud(true)
        listener = TweetService.shared.fetchTweets(user.id, compleation: { tweets in
            self.showTweets = tweets
            HudShowing.shared.showHud(false)
        })
    }
    
    func fetchLikesTweets(){
        HudShowing.shared.showHud(true)
        
         listener = TweetService.shared.fetchLikeReplyUserTweets(user.id) { (tweets) in
            HudShowing.shared.showHud(false)
            self.showTweets = tweets
        }
    }
    
    
    func stopListerFirestore(){
        listener?.remove()
    }
    
    func stopObserve(){
        canceller?.cancel()
    }
    
    
    func fetchData(){
        UserService.shared.checkFollow(user) { result in
            self.isFollowed = result
        }
        
        UserService.shared.getCountFollow(user) { count in
            self.following = count.following
            self.followers = count.followers
        }
    }
    
    
    
    func follow(){
        guard let isFollowed = isFollowed else { return }
        self.isFollowed = nil
        if isFollowed {
            UserService.shared.unfollow(user) {
                self.isFollowed = false
                self.followers -= 1
            }
        }else{
            UserService.shared.follow(user) {
                self.isFollowed = true
                self.followers += 1
            }
        }
    }
    
    

    
}
