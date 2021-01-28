//
//  TestView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 22.01.2021.
//

import SwiftUI


struct TestView: View {
    @State var countElemt: CGFloat = 4.0
    
    
    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 3), count: Int(countElemt))
        VStack{
                Slider(value: $countElemt, in: 2.0...5.0, step: 1.0)
                ScrollView{
                    LazyVGrid(columns: columns){
                        
                        ForEach(0..<120){ _ in
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    VStack{
                                        Image(systemName: "creditcard")
                                            .resizable()
                                            .foregroundColor(.green)
                                            .frame(width: 30, height: 30, alignment: .center)
                                            .aspectRatio(contentMode: .fill)
                                        Text("Bank cards")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 20))
                                            
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1.5))
                                    .shadow(radius: 10)
                                })
                                .padding(.vertical, 10)
                                .padding(.horizontal, 5)
                            
                             
                                
                                
                        }
                        
                        
                    }
                }
            
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
