//
//  LeftMenu.swift
//  TwitterSiwftUI
//
//  Created by Admin on 11.01.2021.
//

import SwiftUI
import SideMenu

struct LeftMenu: UIViewControllerRepresentable {
    @StateObject var authVieModel: AuthViewModel
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = UIHostingController(rootView: LeftMenuTableView(authViewModel: authVieModel))
        let menu = SideMenuNavigationController(rootViewController: view)
   
        return menu
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}



extension LeftMenu{
    class Coordinator: NSObject ,UINavigationControllerDelegate {
        let parent: LeftMenu
        
        init(_ parent: LeftMenu) {
            self.parent = parent
        }
        
    }
}
