//
//  WishlistScreen.swift
//  Masik
//
//  Created by Роман Ломтев on 12.06.2025.
//

import SwiftUI

struct WishlistScreen: View {
    
    var body: some View {
        VStack(spacing: 24) {
            
            // Заголовок
            Text("Вишлист")
                .font(.system(size: 28, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Spacer()
        }
    }
}
