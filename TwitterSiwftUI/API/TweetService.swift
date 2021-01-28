//
//  TweetService.swift
//  TwitterSiwftUI
//
//  Created by Admin on 14.01.2021.
//

import Foundation
import Firebase

class TweetService {
    static let shared = TweetService()
    
    private var userUid: String? {
        Auth.auth().currentUser?.uid
    }
    
  
    
    func uploadTweet(_ caption: String, tweet: Tweet?, compleation: @escaping()->Void){
     
        var colRef: CollectionReference
        
        
        guard let uid = userUid else { return }
        var value: [String: Any] = ["caption": caption,
                                    "uid": uid,
                                    "timestamp": Timestamp(),
                                    "likes": 0,]
        
        if let tweet = tweet {
            colRef = tweet.ref.collection("tweets")
            value["reply"] = tweet.user.username
        }else{
            colRef = TWEETS_REF
        }
        
        
        let addedDocRef = colRef.addDocument(data: value) { docAdded in
            
            compleation()
        }
        
        if tweet != nil {
            let replysValue: [String: Any] = ["tweet": addedDocRef, "timestampLike": Timestamp()]
            USERS_REF.document(uid).collection("replys").addDocument(data: replysValue)
        }
    }
    
    enum FetchType{
        case like
        case reply
    }
    
    func fetchLikeReplyUserTweets(_ uid: String, type: FetchType = .like, compleation: @escaping([Tweet])->Void) -> ListenerRegistration {
        let collection: String
        
        switch type {
        case .like:
            collection = "likes"
        case .reply:
            collection = "replys"
        }
        
       let lister = USERS_REF.document(uid).collection(collection).order(by: "timestampLike", descending: true).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            let count = snapshot.documents.count
     
            var tweets = [Tweet]()
            if  count == 0{
                compleation(tweets)
            }
            snapshot.documents.forEach { document in
                let dictionary = document.data()
                let ref = dictionary["tweet"] as! DocumentReference
                let timesort = (dictionary["timestampLike"] as! Timestamp).dateValue()
               
                
                ref.getDocument {[timesort] (snapshot, error) in
                    guard let snapshot = snapshot else { return }
                    guard let dictionary = snapshot.data() else { return } 
                    let uid = dictionary["uid"] as! String
                    UserService.shared.fetchUser(uid) { user in
                        let tweet = Tweet(user: user, ref: snapshot.reference, id: snapshot.documentID, dictionary: dictionary)
                        tweet.timesort = timesort
                        tweets.append(tweet)
                        
                        if tweets.count == count {
                            tweets.sort{$0.timesort! > $1.timesort! }
                            compleation(tweets)
                        }
                    }
                }
                
            }
        }
        return lister
    }
    
    
    
    func fetchTweets(_ uid: String? = nil, _ ref: DocumentReference? = nil, compleation: @escaping([Tweet])->Void) -> ListenerRegistration{
        
        var collRef: Query
        
        if let ref = ref {
            collRef = ref.collection("tweets")
        }else if let uid = uid{
            collRef = TWEETS_REF.whereField("uid", isEqualTo: uid)
        }else{
            collRef = TWEETS_REF
        }
        
        
        let listener = collRef.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            
            let count = snapshot.documents.count
            var tweets = [Tweet]()
            
            if  count == 0{
                compleation(tweets)
            }
            snapshot.documents.forEach { docTweet in
               let dictionary = docTweet.data()
                let uid = dictionary["uid"] as! String
                
                    UserService.shared.fetchUser(uid) { user in
                        
                        let tweet = Tweet(user: user, ref: docTweet.reference, id: docTweet.documentID, dictionary: dictionary)
                        
                        tweets.append(tweet)
                        
                        if count == tweets.count {
                            tweets.sort{$0.timestamp > $1.timestamp }
                            compleation(tweets)
                        }
                        
                    }
            }
        }
        
        
        return listener
    }
    
    
    func likeTweet(_ tweet: Tweet, compleation: @escaping()->Void){
        
        guard let uid = userUid else { return }
        let value:[String: Any] = ["uid": uid]
        
        tweet.ref.collection("likes").document(uid).setData(value) { error in
            let value: [String: Any] = ["tweet": tweet.ref,
                                        "timestampLike": Timestamp()]
            USERS_REF.document(uid).collection("likes").document(tweet.id).setData(value) { _ in
                compleation()
            }
        }
    }
    
    func unlikeTweet(_ tweet: Tweet, compleation: @escaping()->Void){
        guard let uid = userUid else { return }
        tweet.ref.collection("likes").document(uid).delete { error in
            USERS_REF.document(uid).collection("likes").document(tweet.id).delete { _ in
                compleation()
            }
        }
    }
    
    func checkLike(_ tweet: Tweet, compleation: @escaping(Bool)->Void){
        
        guard let uid = userUid else { return }
        tweet.ref.collection("likes").document(uid).getDocument { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            compleation(snapshot.exists)
            
        }

    }
    
}
