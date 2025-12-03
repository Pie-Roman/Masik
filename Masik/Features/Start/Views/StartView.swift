//
//  StartView.swift
//  Masik
//
//  Created by Роман Ломтев on 20.11.2025.
//

import SwiftUI
import AuthenticationServices

struct StartView: View {
    var body: some View {
        ZStack {
            // Фон в фирменном стиле
            Color(red: 190/255, green: 90/255, blue: 40/255)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                Spacer().frame(height: 40)
                
                // Анимация в кружке
                LottieView(name: "masiklottie")
                .padding(.top, 20)
                
                // Название
                Text("MASIK")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                // Краткое хайповое описание
                Text("The app where couples share moments, memories,\nideas and their sweetest chaos.")
                    .font(.title2)
                    .foregroundColor(Color.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .padding(.top, -10)
                
                Spacer()
                
                // Кнопка Apple Sign In
                SignInWithAppleButton()
                    .frame(height: 50)
                    .padding(.horizontal, 32)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.bottom, 40)
            }
        }
    }
}

struct SignInWithAppleButton: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}

