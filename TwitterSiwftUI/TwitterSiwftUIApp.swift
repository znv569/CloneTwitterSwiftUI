//
//  TwitterSiwftUIApp.swift
//  TwitterSiwftUI
//
//  Created by Admin on 28.12.2020.
//

import SwiftUI
import Firebase



@main
struct TwitterSiwftUIApp: App {
    
    init(){
        FirebaseApp.configure()

        print("main branch")

        print("Проиницилизировано")
        print("BugFix commit")
    }
    
    func newFunt(){

    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
    
}
