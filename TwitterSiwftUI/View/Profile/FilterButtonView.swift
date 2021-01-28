//
//  FilterButtonView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 10.01.2021.
//

import SwiftUI


enum FiltersButtonOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    
    var title: String {
        switch self {

        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
            
        }
    }
}



struct FilterButtonView: View {
    
    private let widthScreen = UIScreen.main.bounds.width
    
    private var widthOption: CGFloat {
        let count = CGFloat( FiltersButtonOptions.allCases.count )
       return ((widthScreen - 20) / count) - (2 * (count - 1))
    }
    
    private var paddingUnderline: CGFloat {
        let numberOption = CGFloat(selectedOption.rawValue)
        let value = (widthOption * numberOption) + (12)

        return value
    }
    
    @Binding var selectedOption: FiltersButtonOptions
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 2){
                ForEach(FiltersButtonOptions.allCases, id: \.self){ option in
                    
                    Button(action: {
                            self.selectedOption = option
                        
                    }, label: {
                        Text(option.title)
                            .frame(width: widthOption)
                            .font(.system(size: 15))
                    })
                    
                    
                }
            }
            
                Rectangle()
                    .frame(width: widthOption - 24, height: 3)
                    .foregroundColor(.blue)
                    .padding(.leading, paddingUnderline)
                    .animation(.spring())

        }
        .padding(.horizontal)
    }
}

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtonView(selectedOption: .constant(.tweets))
    }
}
