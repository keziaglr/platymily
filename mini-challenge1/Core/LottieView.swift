//
//  LottieView.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 04/05/23.
//

import SwiftUI
import Lottie
 
struct LottieView: UIViewRepresentable {
    let animationView = LottieAnimationView()
    @State var lottieFile: String
    @State var animationSpeed : CGFloat
    @State var transform : CGAffineTransform
    @State var loop : Bool = true
 
    func makeUIView(context: UIViewRepresentableContext<LottieView>) ->  UIView {
        let view = UIView(frame: .zero)
        
        let animation = LottieAnimation.named(lottieFile)
        animationView.animation = animation
        animationView.transform = transform
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loop ? .loop : .playOnce
        animationView.animationSpeed = animationSpeed
        animationView.play()
 
        
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
 
        NSLayoutConstraint.activate([
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
 
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
    }
}
