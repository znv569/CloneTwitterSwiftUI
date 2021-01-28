//
//  NewTweetView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 11.01.2021.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    
    @Binding var isPresented: Bool
    @State var textCaption: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel: UploadTweetViewModel
  
    
    init(isPresented: Binding<Bool>, tweet: Tweet? = nil) {
        self._isPresented = isPresented
        self._viewModel = StateObject(wrappedValue: UploadTweetViewModel(AuthViewModel.shared.user!, tweet: tweet))
    }
    
    var body: some View {
        NavigationView{
            
            
            VStack {
                if viewModel.tweet != nil {
                    Text("reply to @\(viewModel.tweet!.user.username)")
                        .foregroundColor(.blue)
                        .font(.system(size: 14, weight: .semibold))
                }
                
                HStack(alignment: .top){
                    KFImage(authViewModel.user?.profileImageUrl)
                        .resizable()
                        .frame(width: 64, height: 64)
                        .scaledToFit()
                        .clipShape(Circle())
                    TextArea("What's happened?", text: $textCaption)
                }
                
                
                .navigationBarItems(leading: Button(action: {self.isPresented.toggle()}, label: {
                    Text("Close")
                }), trailing: Button(action: {
                    viewModel.uploadTweet(textCaption) {
                        textCaption = ""
                        isPresented = false
                    }
                }, label: {
                    Text(viewModel.tweet == nil ? "Tweet" : "Reply")
                        .foregroundColor(.white)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }))
                .padding()
                Spacer()
            }
            
            
            
        }
        
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView(isPresented: .constant(true))
    }
}
