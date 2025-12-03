//
//  LottieView.swift
//  Masik
//
//  Created by Роман Ломтев on 30.11.2025.
//

import SwiftUI
import DotLottie

struct LottieView: View {
    let name: String
    
    var body: some View {
        let animationConfig = AnimationConfig(
            autoplay: true,
            loop: true,
        )
        
        VStack {
            
            DotLottieAnimation(
                fileName: name,
                config: AnimationConfig(
                    autoplay: true,
                    loop: true,
                    layout: Layout(
                        fit: .fitHeight,
                        align: animationConfig.layout?.align ?? []
                    )
                )
            )
            .view()
            .frame(height: 300)
        }
        
        .frame(width: 360, height: 360)
        .clipShape(Circle())
    }
}
