//
//  TextView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 19.01.2021.
//

import SwiftUI




struct TextView: UIViewRepresentable {
    
    //MARK: Property
    @Binding var text: String
    @Binding var heightText: CGFloat
    var placeholder: String
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .placeholderText
        return label
    }()
    
    
    let textView: UITextView = {
        let tw = UITextView(frame: .zero)
        tw.backgroundColor = .white
        tw.isScrollEnabled = true
        tw.isSelectable = true
        tw.font = .systemFont(ofSize: 15)
        return tw
    }()
    
    
    func textViewColor(_ color: UIColor) -> TextView {
        textView.textColor = color
        return self
    }
    
    func backgroundViewColor(_ color: UIColor) -> TextView {
        textView.backgroundColor = color
        return self
    }
    
    func placeholderColor(_ color: UIColor) -> TextView {
        placeholderLabel.textColor = color
        return self
    }
    
    //MARK: Methods
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    
    
    func makeUIView(context: Context) -> UITextView {
        
        textView.text = text
        textView.delegate = context.coordinator
        textView.addSubview(placeholderLabel)
        
        placeholderLabel.isHidden = !text.isEmpty
        
        
        placeholderLabel.text = placeholder
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.leftAnchor.constraint(equalTo: textView.leftAnchor, constant: 5).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 7).isActive = true
        
        return textView
        
    }
    
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    
    //MARK: COORDINATOR
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: TextView
        
        
        init(_ parent: TextView){
            self.parent = parent
        }
        
        
        func textViewDidChange(_ textView: UITextView) {
            
            parent.text = textView.text
            let size = textView.sizeThatFits(textView.bounds.size)
            parent.heightText = size.height
            parent.placeholderLabel.isHidden = !textView.text.isEmpty
            
        }
        
    }
    
    
    
}
