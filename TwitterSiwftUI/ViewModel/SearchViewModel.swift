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
        didSet{ print(searchText) }
    }
    
    init() {
        fetchUsers()
    }
    
    
    
    
    
    func fetchUsers(){
        UserService.shared.fetchUsers { (users) in
            self.users = users
        }
    }
    
    
}


