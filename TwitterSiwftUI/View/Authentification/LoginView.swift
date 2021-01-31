//
//  LoginView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 11.01.2021.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State var attems: Int = 0
    
    
    func login(){
        viewModel.login(email: email, pass: password){ result in
            switch result {
            case .error(let error):
                print(error.localizedDescription)
                attems += 1
            default:
                return
            }
            
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                
                VStack(spacing: 20){
                    Image("twitter-logo")
                        .resizable()
                        .frame(width: 220, height: 220)
                        .padding(.top, 30)
                    CustomTextField(text: $email, placeholder: "Email", imgSysName: "envelope")
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                    
                    CustomSecurutyField(text: $password, placeholder: "Password", imgSysName: "lock"){
                       login()
                    }
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                       
                    
                    
                    HStack{
                        Spacer()
                        Button(action: {}, label: {
                            Text("Forgot password?")
                        })
                        .padding(.trailing, 20)
                        .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        login()
                    }, label: {
                        Text("Sign In")
                    })
                    .foregroundColor(Color(#colorLiteral(red: 0.1076790616, green: 0.6322241426, blue: 0.9511476159, alpha: 1)))
                    .padding()
                    .frame(minWidth: 40, maxWidth: .infinity, alignment: .center)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    
                    
                    Spacer()
                    
                    
                    NavigationLink(
                        destination: NavigationLazyView( RegistrationView() )
                            .navigationBarHidden(true),
                        label: {
                            HStack{
                                Text("Dont have an account?")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                Text("Sign Up")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        })
                        .padding(.bottom, 40)
                    
                    
                    
                }
        
            }
            .background(Color(#colorLiteral(red: 0.1076790616, green: 0.6322241426, blue: 0.9511476159, alpha: 1)))
            .ignoresSafeArea()
        
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
