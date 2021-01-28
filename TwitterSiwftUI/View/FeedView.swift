//
//  FeedView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 29.12.2020.
//

import SwiftUI
import SideMenu
import Kingfisher


struct FeedView: View {
    @State var newTweetPresented: Bool = false
    @State var showLeftMenu: Bool = false
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel: FeedViewModel = FeedViewModel()

    
    var body: some View {
        
        
        ZStack(alignment: .bottomTrailing){
            ScrollView{
                VStack{
                    
                    ForEach(viewModel.tweets) { tweet in
                        NavigationLink(destination: NavigationLazyView( DetailTweetView(tweet) ) ){
                          
                                TweetCell(tweet)
                            }
                            .buttonStyle(MyButtonStyle())
                    }
                }.padding()
            }
            
            
          
            
            
            Button(action: {self.newTweetPresented.toggle()}, label: {
                Image("tweet")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $newTweetPresented, content: {
                NewTweetView(isPresented: $newTweetPresented)
               
            })
        }
        .onAppear{
            viewModel.fetchTweets()
        }
        .onDisappear{
            viewModel.removeObserve()
        }
        .navigationTitle("Home")
        .navigationBarItems(leading: Button(action: {
                                                
            let view = UIHostingController(rootView: LeftMenuTableView(authViewModel: authViewModel))
                                                let menu = SideMenuNavigationController(rootViewController: view)
                                                menu.leftSide = true
                                               
            UIApplication.shared.topMostController?.present(menu, animated: true)
                                                showLeftMenu.toggle()
            
        }, label: {
                                                    KFImage(authViewModel.user?.profileImageUrl)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 30, height: 30, alignment: .center)
                                                        .clipShape(Circle())
                                                        .overlay(RoundedRectangle(cornerRadius: 16)
                                                                    .stroke(Color.black, lineWidth: 0.2))
                                                        .shadow(color: .black, radius: 3)
        }))
       
       
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
