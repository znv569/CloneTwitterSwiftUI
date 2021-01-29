//
//  EditProfileView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 29.01.2021.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    
    @ObservedObject var viewModel = EditpRofileViewModel()
    @State var heightCaption: CGFloat = 70
    @State var isPresentedImagePicker: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    

    var heightCaptionFrame: CGFloat {
        let minCaption: CGFloat = 70
        let maxCaption: CGFloat = 200
        
        if heightCaption < minCaption {
            return minCaption
        }
        if heightCaption > maxCaption {
            return maxCaption
        }
        return heightCaption
    }
    
    var body: some View {
        
        VStack{
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                })
                Spacer()
                Button(action: {
                    viewModel.saveProfile{
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("Save")
                })
            }.padding(.horizontal)
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .semibold))
            ScrollView{
                VStack{
                    
                    
                    Button(action: {
                        isPresentedImagePicker.toggle()
                    }, label: {
                        
                        if viewModel.selectedImage == nil {
                            KFImage(viewModel.profileImageUrl)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120, alignment: .center)
                                .clipShape(Circle())
                                .overlay(RoundedRectangle(cornerRadius: 60).stroke(Color.white, lineWidth: 5.0).shadow(color: .black, radius: 100).cornerRadius(60))
                                .shadow(color: .white, radius: 10)
                                .padding(30)
                                
                        }else{
                            Image(uiImage: viewModel.selectedImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120, alignment: .center)
                                .clipShape(Circle())
                                .overlay(RoundedRectangle(cornerRadius: 60).stroke(Color.white, lineWidth: 5.0).shadow(color: .black, radius: 100).cornerRadius(60))
                                .shadow(color: .white, radius: 10)
                                .padding(30)
                        }
                        
                    })
                    .sheet(isPresented: $isPresentedImagePicker, content: {
                        ImagePicker(image: $viewModel.selectedImage)
                    })
                    CustomTextField(text: $viewModel.email, placeholder: "Email", imgSysName: "envelope")
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    CustomTextField(text: $viewModel.username, placeholder: "Username", imgSysName: "person")
                        .textContentType(.username)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    CustomTextField(text: $viewModel.fullname, placeholder: "Fullname", imgSysName: "person")
                        .textContentType(.nickname)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                    
                    CustomSecurutyField(text: $viewModel.password, placeholder: "Password", imgSysName: "lock"){
                   
                    }
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    TextView(text: $viewModel.caption, heightText: $heightCaption, placeholder: "Описание")
                        .backgroundViewColor(.clear)
                        .placeholderColor(.init(white: 1, alpha: 0.87))
                        .textViewColor(.white)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .frame(minWidth: 50, maxWidth: .infinity)
                        .frame(height: heightCaptionFrame)
                        
                       
                        
                    
                }
            }
           
        }
        .frame(maxWidth: .infinity)
        .background(Color(#colorLiteral(red: 0.1076790616, green: 0.6322241426, blue: 0.9511476159, alpha: 1)).ignoresSafeArea())
        
   
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
