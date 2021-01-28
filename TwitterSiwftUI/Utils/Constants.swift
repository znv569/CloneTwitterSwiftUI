//
//  Constants.swift
//  TwitterSiwftUI
//
//  Created by Admin on 12.01.2021.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")



let USERS_REF = Firestore.firestore().collection("users")

let FOLLOW_REF = Firestore.firestore().collection("follow")

let TWEETS_REF = Firestore.firestore().collection("tweets")
