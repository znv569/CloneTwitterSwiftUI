//
//  SearchViewModel.swift
//  TwitterSiwftUI
//
//  Created by Admin on 12.01.2021.
//

import SwiftUI

class NewTest {
    
}
  
class SearchViewModel: ObservableObject {
    
    
    @Published var users = [User]()
    
    var searchText: String = ""{
        didSet{ fetchUsers(query: searchText) }
    }
    
    init() {
        fetchUsers()
    }
    
    
    
    
    
    func fetchUsers(query: String? = nil){
        
        UserService.shared.fetchUsers (query: searchText.lowercased()){ (users) in
            self.users = users
        }
    }
    
    
}


