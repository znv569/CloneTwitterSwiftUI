//
//  Extentions.swift
//  TwitterSiwftUI
//
//  Created by Admin on 14.01.2021.
//

import SwiftUI
import JGProgressHUD


extension UIColor{
    @nonobjc class var fillGrey4: UIColor {
       return UIColor(red: 238.0 / 255.0, green: 242.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
     }

     @nonobjc class var fillGrey3: UIColor {
       return UIColor(red: 231.0 / 255.0, green: 237.0 / 255.0, blue: 243.0 / 255.0, alpha: 1.0)
     }

     @nonobjc class var fillAccent3: UIColor {
       return UIColor(red: 185.0 / 255.0, green: 196.0 / 255.0, blue: 207.0 / 255.0, alpha: 1.0)
     }
 
}

struct MyButtonStyle: ButtonStyle {
    public func makeBody(configuration: MyButtonStyle.Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 1 : 1)

            // You can also add other animated properties
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
    }
}


struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}


    extension Date {
        var dayExpire: String {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
            formatter.maximumUnitCount = 1
            formatter.unitsStyle = .abbreviated
            let now = Date()
            return formatter.string(from: self, to: now) ?? "0m"
        }
        
        var fulltime: String {
            let dateFormatterGet = DateFormatter()
            
            dateFormatterGet.dateFormat = "dd-MM-yyyy HH:mm:ss"
           return dateFormatterGet.string(from: self)
        }
        
      
    }



class HudShowing {

    private let hud: JGProgressHUD = {
        let jgp = JGProgressHUD(style: .dark)
        jgp.textLabel.text = "Loading..."
        return jgp
    }()
    
    static let shared = HudShowing()
    
    func showHud(_ show: Bool){
        show ? hud.show(in: UIApplication.shared.topMostController!.view) : hud.dismiss()
    }
}



extension UIApplication{
    var topMostController: UIViewController? {
            
            guard
                let window = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first,
                let rootViewController = window.rootViewController else {
                    return nil
            }
            
            var topController = rootViewController
            
            while let newTopController = topController.presentedViewController {
                topController = newTopController
            }
            
            return topController
        }
    
        func endEditing() {
          sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
        func dismiss() {
            UIApplication.shared.topMostController!.dismiss(animated: true, completion: nil)
        }
}
