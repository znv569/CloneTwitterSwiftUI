//
//  ChatBublbe.swift
//  TwitterSiwftUI
//
//  Created by Admin on 07.01.2021.
//

import SwiftUI

struct ChatBublbe: Shape {
    var isCurrentUser: Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, isCurrentUser ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        return Path(path.cgPath)
    }
    

}

struct ChatBublbe_Previews: PreviewProvider {
    static var previews: some View {
        ChatBublbe(isCurrentUser: false)
    }
}
