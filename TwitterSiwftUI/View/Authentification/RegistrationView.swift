//
//  RegistrationView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 11.01.2021.
//

import SwiftUI

struct RegistrationView: View {
    
    @State var fullname: String = ""
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var isPresentedImagePicker: Bool = false
    @State var profileUISelectedImage: UIImage?
    @EnvironmentObject var viewModel: AuthViewModel
    
    private var heightFrame: CGFloat{
        return UIScreen.main.bounds.height
    }
    
    func register(){
        guard let image = profileUISelectedImage else { return }
        viewModel.registerUser(email: email, password: password, login: username, fullname: fullname, profileImage: image)
    }
    
   
    
    var body: some View {
        
        
 
            ScrollView{
                VStack(spacing: 20){
                    
                    Button(action: {self.isPresentedImagePicker.toggle()}, label: {
                        if let image = profileUISelectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .cornerRadius(140 / 2)
                                .overlay(RoundedRectangle(cornerRadius: 140)
                                            .stroke(Color.white, lineWidth: 3))
                                .padding(.top, 40)
                             
                        }else{
                            Image("plus_photo")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .padding(.top, 40)
                                .foregroundColor(.white)
                        }
                    }).sheet(isPresented: $isPresentedImagePicker, content: {
                        ImagePicker(image: $profileUISelectedImage)
                    })
                   
                       
                    CustomTextField(text: $email, placeholder: "Email", imgSysName: "envelope")
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    CustomTextField(text: $username, placeholder: "Username", imgSysName: "person")
                        .textContentType(.username)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    CustomTextField(text: $fullname, placeholder: "Fullname", imgSysName: "person")
                        .textContentType(.nickname)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                    
                    CustomSecurutyField(text: $password, placeholder: "Password", imgSysName: "lock"){
                        register()
                    }
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                      
                    
                    
                
                    
                    Button(action: {
                        register()
                    }, label: {
                        Text("Sign Up")
                    })
                    .foregroundColor(Color(#colorLiteral(red: 0.1076790616, green: 0.6322241426, blue: 0.9511476159, alpha: 1)))
                    .padding()
                    .frame(minWidth: 40, maxWidth: .infinity, alignment: .center)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    
                    
                    Spacer()
                    
                    
                    Button(action: {
                            
                        mode.wrappedValue.dismiss()
                        
                    }, label: {
                        HStack{
                            Text("Already have an account?")
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                            Text("Sign In")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                        }
                    })
                    .padding(.bottom, 20)
                }
                .frame(height: heightFrame)
               
            } .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
            .edgesIgnoringSafeArea(.top)
            .background(Color(#colorLiteral(red: 0.1076790616, green: 0.6322241426, blue: 0.9511476159, alpha: 1)).edgesIgnoringSafeArea(.all))
        
        
       
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
